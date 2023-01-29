class CouponService
  def update_coupons
    connection = SellixApiConnectionService.new.connection
    response = connection.get('coupons')
    coupons = response.body['data']['coupons']
    coupons.each do |coupon|
      db_coupon = Coupon.find_by(uniqid: coupon['uniqid'])
      db_coupon.present? ? update_coupon(db_coupon) : create_coupon(coupon)
    end
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
