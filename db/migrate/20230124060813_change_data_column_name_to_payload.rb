class ChangeDataColumnNameToPayload < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :data, :payload
  end
end
