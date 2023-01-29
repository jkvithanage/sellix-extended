class SellixApiConnectionService
  def initialize
    @base_url = 'https://dev.sellix.io/v1/'
  end

  def connection
    Faraday.new(@base_url) do |conn|
      conn.request :authorization, 'Bearer', -> { Rails.application.credentials.sellix_key }
      conn.response :json
    end
  end
end
