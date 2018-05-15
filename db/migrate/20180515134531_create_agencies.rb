class CreateAgencies < ActiveRecord::Migration[5.2]
  def change
    create_table :agencies do |t|
      t.integer :store_number, index: true, null: false
      t.references :dive_center, foreign_key: true, index: true, null: false
      t.references :training_organization, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
