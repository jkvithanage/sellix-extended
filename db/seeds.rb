puts 'Seeding begins.....'
connection = SellixApiConnectionService.new.connection
# Retrieve orders from sellix
order_response = connection.get('orders')
orders = order_response.body['data']['orders']
orders.reverse_each do |order|
  next unless order['status'] == 'COMPLETED'

  p Order.create(
    uniqid: order['uniqid'],
    order_type: order['type'],
    total: order['total'],
    crypto_exchange_rate: order['crypto_exchange_rate'],
    customer_email: order['customer_email'].downcase,
    gateway: order['gateway'],
    crypto_amount: order['crypto_amount'],
    crypto_received: order['crypto_received'],
    country: order['country'],
    coupon_uniqid: order['coupon_id'],
    discount: order['discount'],
    created_at: order['created_at'],
    updated_at: order['updated_at']
  )
end

# Retrieve feebacks from sellix
feeback_response = connection.get('feedback')
feedback = feeback_response.body['data']['feedback']
feedback.each do |f|
  p Feedback.create(
    uniqid: f['uniqid'],
    score: f['score'],
    message: f['message'],
    created_at: f['created_at'],
    updated_at: f['updated_at'],
    invoice: f['invoice'],
    product: f['product']
  )
end

# Retrieve coupons from sellix
coupons_response = connection.get('coupons')
coupons = coupons_response.body['data']['coupons']
coupons.each do |coupon|
  p Coupon.create(
    uniqid: coupon['uniqid'],
    code: coupon['code'],
    discount: coupon['discount'],
    used: coupon['used'],
    max_uses: coupon['max_uses'],
    created_at: coupon['created_at'],
    updated_at: coupon['updated_at']
  )
end

# Retrieve products from sellix
products_response = connection.get('products')
products = products_response.body['data']['products']
products.each do |product|
  response = connection.get("products/#{product['uniqid']}")
  product = response.body['data']['product']
  p Product.create(
    uniqid: product['uniqid'],
    title: product['title'],
    price: product['price'],
    warranty: product['warranty'],
    feedback: product['feedback'],
    sold_count: product['sold_count'],
    average_score: product['average_score']
  )
end
puts 'Seeding ends......'
