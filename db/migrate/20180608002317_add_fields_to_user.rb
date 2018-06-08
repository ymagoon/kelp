class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :full_name, :string, index: true
    add_column :users, :username, :string
    add_column :users, :phone, :string
    add_reference :users, :location, foreign_key: true
  end
end
