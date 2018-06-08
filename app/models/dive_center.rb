class DiveCenter < ApplicationRecord
  belongs_to :location
  has_many :agencies
  has_many :training_organizations, through: :agencies

  email_expression = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  url_expression = /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9]\.[^\s]{2,})/

  validates :name, presence: true
  validates :website, :fb, :twitter, :youtube, :google, :linkedin, allow_blank: true, format: { with: url_expression }
  validates :email, allow_blank: true, format: { with: email_expression }

  # searchkick

  def ssi?
    agencies = self.training_organizations
    agencies.each { |agency| return true if agency.short_name == 'SSI' }

    return false
  end

  def sdi?
    agencies = self.training_organizations
    agencies.each { |agency| return true if agency.short_name == 'SDI' }

    return false
  end

  def padi?
    agencies = self.training_organizations
    agencies.each { |agency| return true if agency.short_name == 'PADI' }

    return false
  end
end
