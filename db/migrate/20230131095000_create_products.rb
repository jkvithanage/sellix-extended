class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: false, primary_key: :uniqid do |t|
      t.string :uniqid, null: false
      t.string :title
      t.decimal :price
      t.integer :warranty
      t.json :feedback
      t.integer :sold_count
      t.decimal :average_score

      t.index :uniqid, unique: true
    end
  end
end
