class OrdersController < ApplicationController
  def index
    @filter = OrderFilterService.new(params[:filter])
    @orders = params[:filter].present? ? @filter.scope.ordered : Order.ordered

    emails = Order.all.map(&:customer_email)
    @customers = emails.uniq.sort

    @coupons = Coupon.ordered
    @total = total_sale
    @discount = total_discount
    @fiat, @crypto = fiat_sales
  end

  private

  def total_sale
    total = 0
    @orders.each do |order|
      total += order.total
    end
    total
  end

  def total_discount
    total = 0
    @orders.each do |order|
      total += order.discount
    end
    total
  end

  def fiat_sales
    fiat, crypto = 0, 0
    @orders.each do |order|
      if ['STRIPE', 'PAYPAL', 'PAYDASH'].include? order.gateway
        fiat += order.total
      else
        crypto += order.total
      end
    end

    [fiat, crypto]
  end
end
