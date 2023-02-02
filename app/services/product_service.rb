# Same as products, we always keep calling Sellix API to keep local db up to date.
class ProductService
  def initialize
    @connection = SellixApiConnectionService.new.connection
    response = @connection.get('products')
    @products = response.body['data']['products']
  end

  def update_products
    @products.each do |product|
      response = @connection.get("products/#{product['uniqid']}")
      # Have to call API per each product to get sold_count and average_score
      full_product_object = response.body['data']['product']
      db_product = Product.find_by(uniqid: product['uniqid'])
      db_product.present? ? update_product(db_product, full_product_object) : create_product(full_product_object)
    end

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

  def update_product(db_product, product)
    db_product.update(
      title: product['title'],
      price: product['price'],
      warranty: product['warranty'],
      feedback: product['feedback'],
      sold_count: product['sold_count'],
      average_score: product['average_score']
    )
  end

  def create_product(product)
    Product.create(
      uniqid: product['uniqid'],
      title: product['title'],
      price: product['price'],
      warranty: product['warranty'],
      feedback: product['feedback'],
      sold_count: product['sold_count'],
      average_score: product['average_score']
    )
  end
end
