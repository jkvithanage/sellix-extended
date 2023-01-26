class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    # puts "NEW EVENT TRIGGERED: #{event.source} !!!"
    case event.source
    when 'feedbacks'
      handle_feedback(event)
    end
  end

  private

  def handle_feedback(event)
    CreateFeedbackService.new(event).create
  end
end
