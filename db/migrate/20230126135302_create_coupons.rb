class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons, id: false, primary_key: :uniqid do |t|
      t.string :uniqid, null: false
      t.string :code
      t.decimal :discount
      t.integer :used
      t.datetime :expire_at
      t.integer :created_at
      t.integer :updated_at

      t.index :uniqid, unique: true
    end
  end
end
