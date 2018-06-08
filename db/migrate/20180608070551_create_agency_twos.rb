class CreateAgencyTwos < ActiveRecord::Migration[5.2]
  def change
    create_table :agency_twos do |t|
      t.integer :store_number, null: false
      t.references :dc_two, foreign_key: true, null: false
      t.references :training_organization, foreign_key: true, index: true, null: false

      t.timestamps
      t.timestamps
    end
  end
end
