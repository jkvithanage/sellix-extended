# Retrieve orders from sellix
response = connection.get('orders')
orders = response.body['data']['orders']
orders.reverse_each do |order|
  next unless order['status'] == 'COMPLETED'

  Order.create(
    uniqid: order['uniqid'],
    order_type: order['type'],
    total: order['total'],
    crypto_exchange_rate: order['crypto_exchange_rate'],
    customer_email: order['customer_email'],
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
