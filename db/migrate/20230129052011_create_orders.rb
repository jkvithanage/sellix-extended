class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: false, primary_key: :uniqid do |t|
      t.string :uniqid, null: false
      t.string :order_type
      t.decimal :total
      t.decimal :crypto_exchange_rate
      t.string :customer_email
      t.string :gateway
      t.decimal :crypto_amount
      t.decimal :crypto_received
      t.string :country
      t.decimal :discount
      t.integer :created_at
      t.integer :updated_at
      t.string :coupon_uniqid

      t.index :uniqid, unique: true
    end
  end
end
