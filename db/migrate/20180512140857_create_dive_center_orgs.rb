class CreateDiveCenterOrgs < ActiveRecord::Migration[5.2]
  def change
    create_table :dive_center_orgs do |t|
      t.integer :store_number, null: false, index: true
      t.references :dive_center, foreign_key: true, index: true, null: false
      t.references :dive_training_org, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
