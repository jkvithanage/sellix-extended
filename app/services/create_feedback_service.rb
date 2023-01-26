class CreateFeedbackService
  def initialize(event)
    @event = event
  end

  def create
    feedback = Feedback.new(
      uniqid: @event['uniqid'],
      score: @event['score'],
      message: @event['message'],
      created_at: @event['created_at'],
      updated_at: @event['updated_at'],
      invoice: @event['invoice'],
      product: @event['product']
    )

    render json: { status: :ok } if feedback.save
  end
end
