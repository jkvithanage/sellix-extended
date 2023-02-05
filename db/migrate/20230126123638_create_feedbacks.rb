class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.string :uniqid, null: false
      t.integer :score
      t.text :message
      t.integer :created_at
      t.integer :updated_at
      t.references :order
      t.references :product

      t.index :uniqid, unique: true
    end
  end
end
