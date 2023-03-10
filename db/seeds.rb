puts 'Seeding begins.....'
connection = SellixApiConnectionService.new.connection
# Retrieve products from sellix
products_response = connection.get('products')
products = products_response.body['data']['products']
product_attrs = products.map do |product|
  response = connection.get("products/#{product['uniqid']}")
  product = response.body['data']['product']
  hash = {
    uniqid: product['uniqid'],
    title: product['title'],
    price: product['price'],
    warranty: product['warranty'],
    sold_count: product['sold_count'],
    average_score: product['average_score']
  }
  p hash
end

p Product.upsert_all(product_attrs.reverse, unique_by: :uniqid, record_timestamps: false)

# Retrieve coupons from sellix
coupons_response = connection.get('coupons')
coupons = coupons_response.body['data']['coupons']
coupon_attrs = coupons.map do |coupon|
  hash = {
    uniqid: coupon['uniqid'],
    code: coupon['code'],
    discount: coupon['discount'],
    used: coupon['used'],
    max_uses: coupon['max_uses'],
    expire_at: coupon['expire_at'],
    created_at: coupon['created_at'],
    updated_at: coupon['updated_at']
  }
  p hash
end

p Coupon.upsert_all(coupon_attrs.reverse, unique_by: :uniqid, record_timestamps: false)

# Retrieve orders from sellix
order_response = connection.get('orders')
orders = order_response.body['data']['orders']
order_attrs = orders.map do |order|
  next unless order['status'] == 'COMPLETED'

  hash = {
    uniqid: order['uniqid'],
    order_type: order['type'],
    total: order['total'],
    crypto_exchange_rate: order['crypto_exchange_rate'],
    customer_email: order['customer_email'].downcase,
    gateway: order['gateway'],
    crypto_amount: order['crypto_amount'],
    crypto_received: order['crypto_received'],
    country: order['country'],
    discount: order['discount'],
    created_at: order['created_at'],
    updated_at: order['updated_at'],
    coupon_uniqid: order['coupon_id']
  }
  p hash
end

uniq_order_attrs = order_attrs.reverse.compact.uniq { |order| order[:uniqid] }
p Order.upsert_all(uniq_order_attrs, unique_by: :uniqid, record_timestamps: false)

# Retrieve feebacks from sellix
feeback_response = connection.get('feedback')
feedback = feeback_response.body['data']['feedback']
feedback_attrs = feedback.map do |f|
  hash = {
    uniqid: f['uniqid'],
    score: f['score'],
    message: f['message'],
    created_at: f['created_at'],
    updated_at: f['updated_at'],
    invoice_uniqid: f['invoice_id'],
    product_uniqid: f['product_id']
  }
  p hash
end

p Feedback.upsert_all(feedback_attrs.reverse, unique_by: :uniqid, record_timestamps: false)

puts 'Seeding ends......'
