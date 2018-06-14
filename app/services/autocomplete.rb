class Autocomplete
  MODELS_TO_SEARCH = [Location, DiveCenter]

  def initialize(query)
    @query = query
  end

  def self.call(query)
    new(query).results
  end

  # def call
    # results.map do |result|
    #   {
    #     hint: build_hint(result),
    #     record_type: result.class.name
    #     record_id: result.id
    #   }
    # end
  # end

  # private

  def results
    Searchkick.search @query, index_name: [Location, DiveCenter]
  end

  # def build_hint(record)
  #   case record.class.to_s
  #     when "Location" then "Country: #{record.country} City: #{record.city}"
  #     when "DiveCenter" then "Name: #{record.name}"
  #   end
  # end
end
