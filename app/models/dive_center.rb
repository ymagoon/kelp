class DiveCenter < ApplicationRecord
  belongs_to :location
  has_many :agencies
  has_many :training_organizations, through: :agencies

  email_expression = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  url_expression = /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9]\.[^\s]{2,})/

  validates :name, presence: true
  validates :website, :fb, :twitter, :youtube, :google, :linkedin, allow_blank: true, format: { with: url_expression }
  validates :fb, :twitter, :youtube, :google, :linkedin, allow_blank: true, format: { with: url_expression }
  validates :email, allow_blank: true, format: { with: email_expression }

  searchkick  settings: {
                analysis: {
                   filter: {
                      nGram_filter: {
                         type: "nGram",
                         min_gram: 2,
                         max_gram: 20,
                         token_chars: [
                            "letter",
                            "digit",
                            "punctuation",
                            "symbol"
                         ]
                      }
                   },
                   analyzer: {
                      nGram_analyzer: {
                         type: "custom",
                         tokenizer: "whitespace",
                         filter: [
                            "lowercase",
                            "asciifolding",
                            "nGram_filter"
                         ]
                      },
                      whitespace_analyzer: {
                         type: "custom",
                         tokenizer: "whitespace",
                         filter: [
                            "lowercase",
                            "asciifolding"
                         ]
                      }
                   }
                }
             },
             merge_mappings: true,
             mappings: {
               dive_centers: {
                 _all: {
                   analyzer: "nGram_analyzer",
                   search_analyzer: "whitespace_analyzer"
                 },
                 properties: {
                   name: {
                     type: "text",
                   },
                   dive_center_type: {
                     type: "keyword",
                   },
                   rent_equipment: {
                     type: "boolean",
                   }
             #       nitrox: {
             #         type: "boolean",
             #       },
             #       rent_computer: {
             #         type: "boolean",
             #       },
             #       lodging: {
             #         type: "boolean",
             #       },
             #       restaurant: {
             #         type: "boolean",
             #       },
             #       bar: {
             #         type: "boolean",
             #       },
             #       transfers: {
             #         type: "boolean",
             #       },
             #       pool: {
             #         type: "boolean",
             #       }
             #       primary_phone: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       mobile_phone: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       website: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       email: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       fax: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       tripadvisor: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       fb: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       twitter: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       youtube: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       google: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       linkedin: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       blog: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       project_aware: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
             #       created_at: {
             #         type: "date",
             #         index: false
             #         include_in_all: false
             #       },
             #       updated_at: {
             #         type: "date",
             #         index: false
             #         include_in_all: false
             #       },
             #       hours_of_operation: {
             #         type: "text",
             #         index: false
             #         include_in_all: false
             #       },
                 }
               }
             }

               # def search_data
  #   {
  #     name: name,
  #     dive_center_type: dive_center_type,
  #     rent_equipment: rent_equipment,
  #     nitrox: nitrox,
  #     rent_computer: rent_computer,
  #     lodging: lodging,
  #     restaurant: restaurant,
  #     bar: bar,
  #     transfers: transfers,
  #     pool: pool,
  #     city: location.city,
  #     state: location.state,
  #     country: location.country
  #   }
  # end

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
