class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :uniqid
      t.string :code
      t.decimal :discount
      t.integer :used
      t.datetime :expire_at
      t.integer :created_at
      t.integer :updated_at
    end
  end
end
