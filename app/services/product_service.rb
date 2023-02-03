# Same as products, we always keep calling Sellix API to keep local db up to date.
class ProductService
  def initialize
    @connection = SellixApiConnectionService.new.connection
    response = @connection.get('products')
    @products = response.body['data']['products']
  end

  def update_products
    product_attrs = @products.map do |product|
      response = @connection.get("products/#{product['uniqid']}")
      product = response.body['data']['product']
      {
        uniqid: product['uniqid'],
        title: product['title'],
        price: product['price'],
        warranty: product['warranty'],
        feedback: product['feedback'],
        sold_count: product['sold_count'],
        average_score: product['average_score']
      }
    end

    Product.upsert_all(product_attrs, unique_by: :uniqid, record_timestamps: false)

    delete_products
  end

  private

  def delete_products
    uniqids = []
    @products.each do |product|
      uniqids << product['uniqid']
    end
    Product.all.each do |db_product|
      db_product.destroy unless uniqids.any? { |id| id == db_product.uniqid }
    end

    Product.count
  end
end
