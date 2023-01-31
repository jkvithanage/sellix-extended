class OrderService
  def initialize(event)
    @event = event
  end

  def create_order
    order = Order.create(
      uniqid: @event.payload['data']['uniqid'],
      order_type: @event.payload['data']['type'],
      total: @event.payload['data']['total'],
      crypto_exchange_rate: @event.payload['data']['crypto_exchange_rate'],
      customer_email: @event.payload['data']['customer_email'],
      gateway: @event.payload['data']['gateway'],
      crypto_amount: @event.payload['data']['crypto_amount'],
      crypto_received: @event.payload['data']['crypto_received'],
      country: @event.payload['data']['country'],
      coupon_uniqid: @event.payload['data']['coupon_id'],
      discount: @event.payload['data']['discount'],
      created_at: @event.payload['data']['created_at'],
      updated_at: @event.payload['data']['updated_at']
    )

    CouponService.new.update_coupons if order.coupon_uniqid.present?
  end
end
