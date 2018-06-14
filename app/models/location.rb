class Location < ApplicationRecord
  belongs_to :training_organization, optional: true
  belongs_to :dive_center, optional: true

  after_commit :reindex_dive_centers
  searchkick searchable: [:city, :state, :country]

   def search_data
    {
      city: city,
      state: state,
      country: country
    }
  end

  # FIX ME!!! right now, location.dive_center is not working??? SO reindex everything, unfortuntaely.
  def reindex_dive_centers
    DiveCenter.reindex
  end

  def self.missing_details
    Location.all.select do |loc|
      loc.address_1 == nil || loc.city == nil || loc.state == nil || loc.country == nil || loc.postal_code == nil
    end
  end

  def self.missing_address_1
    Location.where(address_1: nil)
  end

  def self.missing_address_2
    Location.where(address_2: nil)
  end

  def self.missing_city
    Location.where(city: nil)
  end

  def self.missing_state
    Location.where(state: nil)
  end

  def self.missing_country
    Location.where(country: nil)
  end

  def self.missing_postal_code
    Location.where(postal_code: nil)
  end
end
