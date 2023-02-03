class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :uniqid
      t.string :order_type
      t.decimal :total
      t.decimal :crypto_exchange_rate
      t.string :customer_email
      t.string :gateway
      t.decimal :crypto_amount
      t.decimal :crypto_received
      t.string :country
      t.string :coupon_uniqid
      t.decimal :discount
      t.integer :created_at
      t.integer :updated_at

      t.index :uniqid, unique: true
    end
  end
end
