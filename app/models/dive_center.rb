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
               dive_center: {
                  dynamic_templates:[
                     {
                        string_template: {
                           match: "*",
                           match_mapping_type: "string",
                           mapping: {
                              "fields": {
                              },
                              ignore_above: 30000,
                              type: "keyword"
                           }
                        }
                     }
                  ],
                  properties: {
                     bar: {
                        "type": "boolean"
                     },
                     city: {
                        type: "keyword",
                        fields: {
                           analyzed: {
                              type: "text",
                              analyzer: "nGram_analyzer",
                              search_analyzer: "whitespace_analyzer"
                           }
                        },
                        ignore_above: 30000
                     },
                     country: {
                        type: "keyword",
                        fields: {
                           analyzed: {
                              type: "text",
                              analyzer: "nGram_analyzer",
                              search_analyzer: "whitespace_analyzer"
                           }
                        },
                        ignore_above: 30000
                     },
                     dive_center_type: {
                        type: "keyword",
                        ignore_above: 30000
                     },
                     lodging: {
                        type: "boolean"
                     },
                     name: {
                        type: "keyword",
                        fields: {
                           analyzed: {
                              type: "text",
                              analyzer: "nGram_analyzer",
                              search_analyzer: "whitespace_analyzer"
                           }
                        },
                        ignore_above: 30000
                     },
                     nitrox: {
                        type: "boolean"
                     },
                     pool: {
                        type: "boolean"
                     },
                     rent_equipment: {
                        type: "boolean"
                     },
                     restaurant: {
                        type: "boolean"
                     },
                     state: {
                        type: "keyword",
                        fields: {
                           analyzed: {
                              type: "text",
                              analyzer: "nGram_analyzer",
                              search_analyzer: "whitespace_analyzer"
                           }
                        },
                        ignore_above: 30000
                     },
                     transfers: {
                       type: "boolean"
                     }
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
