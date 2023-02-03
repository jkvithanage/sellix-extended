class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :uniqid
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
