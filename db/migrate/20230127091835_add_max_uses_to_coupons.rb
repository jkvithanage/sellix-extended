class AddMaxUsesToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :max_uses, :integer
  end
end
