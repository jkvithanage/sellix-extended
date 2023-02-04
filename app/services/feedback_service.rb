class FeedbackService
  def initialize(event)
    @event = event
  end

  def create_feedback
    feedback = Feedback.create(
      uniqid: @event.payload['data']['uniqid'],
      score: @event.payload['data']['score'],
      message: @event.payload['data']['message'],
      created_at: @event.payload['data']['created_at'],
      updated_at: @event.payload['data']['updated_at'],
      invoice: @event.payload['data']['invoice'],
      product: @event.payload['data']['product']
    )

    handle_coupon(feedback) if feedback.score == 5
  end

  private

  def handle_coupon(feedback)
    email = feedback.invoice['customer_email']
    code = email.split('@').first
    connection = SellixApiConnectionService.new.connection

    # Update local db
    CouponService.new.update_coupons

    if Coupon.find_by(code: code).present?
      # Update coupon on sellix
      p 'Coupon updated'
      put_coupon(Coupon.find_by(code: code), connection)
    else
      # Create a coupon on sellix
      p 'New coupon created'
      post_coupon(code, connection)
    end
  end

  def put_coupon(coupon, connection)
    payload = {
      discount_value: coupon.discount,
      max_uses: coupon.max_uses + 1
    }

    connection.put("coupons/#{coupon.uniqid}") do |req|
      req.body = payload.to_json
      req.headers['Content-Type'] = 'application/json'
    end
  end

  def post_coupon(code, connection)
    payload = {
      code: code,
      discount_value: 10,
      discount_type: 'PERCENTAGE',
      discount_order_type: 'TOTAL',
      disabled_with_volume_discounts: false,
      all_recurring_bill_invoices: false,
      max_uses: 1
    }

    connection.post('coupons') do |req|
      req.body = payload.to_json
      req.headers['Content-Type'] = 'application/json'
    end

    CouponService.new.update_coupons
  end
end
