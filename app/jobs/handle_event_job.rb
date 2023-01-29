class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    # puts "NEW EVENT TRIGGERED: #{event.source} !!!"
    case event.source
    when 'feedbacks'
      handle_feedback(event)
    when 'orders'
      handle_orders(event)
    end
  end

  private

  def handle_feedback(event)
    CreateFeedbackService.new(event).create_feedback
  end

  def handle_orders(event)
    case event.payload['event']
    when 'order:paid'
      CreateOrderService.new(event).create_order
    end
  end
end
