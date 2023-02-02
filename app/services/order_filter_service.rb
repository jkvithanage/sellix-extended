class OrderFilterService
  attr_reader :date_from, :date_to

  def initialize(params)
    params ||= {}
    @date_from = parse_date(params[:date_from], 30.days.ago.to_time.to_s)
    @date_to = parse_date(params[:date_to], Time.now.to_s)
    @customer = params[:customer]
    @coupon = params[:coupon]
  end

  def scope
    if @customer == '' && @coupon == ''
      Order.where('updated_at BETWEEN ? AND ?', @date_from.to_time.to_i, @date_to.to_time.to_i + Time.now.gmt_offset)
    elsif @coupon == ''
      Order
        .where('updated_at BETWEEN ? AND ?', @date_from.to_time.to_i, @date_to.to_time.to_i + Time.now.gmt_offset)
        .where(customer_email: @customer)
    elsif @customer == ''
      Order
        .where('updated_at BETWEEN ? AND ?', @date_from.to_time.to_i, @date_to.to_time.to_i + Time.now.gmt_offset)
        .where(coupon_uniqid: @coupon)
    else
      Order
        .where('updated_at BETWEEN ? AND ?', @date_from.to_time.to_i, @date_to.to_time.to_i + Time.now.gmt_offset)
        .where(customer_email: @customer)
        .where(coupon_uniqid: @coupon)
    end
  end

  private

  def parse_date(date_string, default)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    default
  end
end
