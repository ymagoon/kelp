class CreateDiveTrainingOrgs < ActiveRecord::Migration[5.2]
  def change
    create_table :dive_training_orgs do |t|
      t.string :long_name
      t.string :short_name, index: true
      t.string :fax
      t.string :primary_phone
      t.string :website
      t.string :email
      t.references :location, foreign_key: true, index: true
      t.timestamps
    end
  end
end
