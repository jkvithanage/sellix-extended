class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.string :uniqid
      t.integer :score
      t.text :message
      t.datetime :created_at
      t.datetime :updated_at
      t.json :invoice
      t.json :product
    end
  end
end
