class CouponService
  def initialize
    connection = SellixApiConnectionService.new.connection
    response = connection.get('coupons')
    @coupons = response.body['data']['coupons']
  end

  def update_coupons
    @coupons.each do |coupon|
      db_coupon = Coupon.find_by(uniqid: coupon['uniqid'])
      db_coupon.present? ? update_coupon(db_coupon) : create_coupon(coupon)
    end

    delete_coupons
  end

  private

  def delete_coupons
    uniqids = []
    @coupons.each do |coupon|
      uniqids << coupon['uniqid']
    end
    Coupon.all.each do |db_coupon|
      db_coupon.destroy unless uniqids.any? { |id| id == db_coupon.uniqid }
    end

    Coupon.count
  end

  def update_coupon(db_coupon)
    db_coupon.update(
      code: db_coupon['code'],
      discount: db_coupon['discount'],
      used: db_coupon['used'],
      max_uses: db_coupon['max_uses'],
      created_at: db_coupon['created_at'],
      updated_at: db_coupon['updated_at']
    )
  end

  def create_coupon(coupon)
    Coupon.create(
      uniqid: coupon['uniqid'],
      code: coupon['code'],
      discount: coupon['discount'],
      used: coupon['used'],
      max_uses: coupon['max_uses'],
      created_at: coupon['created_at'],
      updated_at: coupon['updated_at']
    )
  end
end
