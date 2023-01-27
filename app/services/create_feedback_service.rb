class CreateFeedbackService
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

    handle_coupon(feedback)
  end

  private

  def handle_coupon(feedback)
    email = feedback.invoice['email']
    code = email.split('@').first
    connection = SellixApiConnectionService.new.connection
    if Coupon.find_by(code: code).present?
      update_coupon(Coupon.find_by(code: code), connection)
    else
      Coupon.create(code: code, max_uses: 1, discount: 10.0)
    end
  end

  def update_coupon(coupon, connection)
    payload = {
      discount: coupon.discount,
      max_uses: coupon.max_uses + 1
    }
    connection.put('coupons', payload, "Content-Type" => "application/json")
  end
end
