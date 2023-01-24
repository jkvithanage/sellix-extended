class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    puts "NEW EVENT TRIGGERED: #{event.source} !!!"
  end
end
