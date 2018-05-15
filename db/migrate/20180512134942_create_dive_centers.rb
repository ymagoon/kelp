class CreateDiveCenters < ActiveRecord::Migration[5.2]
  def change
    create_table :dive_centers do |t|
      t.string :name, null: false, index: true
      t.string :primary_phone, default: ''
      t.string :mobile_phone, default: ''
      t.string :website, default: ''
      t.string :email, default: ''
      t.string :fax, default: ''
      t.string :tripadvisor, default: ''
      t.string :fb, default: ''
      t.string :twitter, default: ''
      t.string :youtube, default: ''
      t.string :google, default: ''
      t.string :linkedin, default: ''
      t.string :blog, default: ''
      t.string :project_aware, default: ''
      t.string :agency_type
      t.references :location, foreign_key: true, null: false, index: true
      t.timestamps
    end
  end
end
