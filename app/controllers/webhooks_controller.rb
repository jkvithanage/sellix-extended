class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # TODO: verify authenticity based on this X-Sellix-Signature
    # puts "X-Sellix-Signature: #{request.headers['X-Sellix-Signature']}"

    event = Event.create(
      payload: params,
      source: params[:source]
    )
    HandleEventJob.perform_later(event)
    render json: { status: :ok }
  end
end
