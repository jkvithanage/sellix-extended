# Sellix haven't provided webhook endpoints for coupons.
# So we have to sync them based on other events to keep the local db up to date.

class CouponService
  def initialize
    connection = SellixApiConnectionService.new.connection
    response = connection.get('coupons')
    @coupons = response.body['data']['coupons']
  end

  def update_coupons
    coupon_attrs = @coupons.map do |coupon|
      {
        uniqid: coupon['uniqid'],
        code: coupon['code'],
        discount: coupon['discount'],
        used: coupon['used'],
        max_uses: coupon['max_uses'],
        expire_at: coupon['expire_at'],
        created_at: coupon['created_at'],
        updated_at: coupon['updated_at']
      }
    end

    Coupon.upsert_all(coupon_attrs.reverse, unique_by: :uniqid, record_timestamps: false)

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
end
