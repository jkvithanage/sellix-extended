# Same as coupons, we always keep calling Sellix API to keep out local db up to date.
class ProductService
  def initialize
    connection = SellixApiConnectionService.new.connection
    response = connection.get('products')
    @products = response.body['data']['products']
  end
end
