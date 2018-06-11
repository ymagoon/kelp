class QueryFilter
  def initialize(dive_centers, params)
    @dive_centers = dive_centers
    @params = params
  end

  def build_training_organization_filters
    # fix this! - needs to be done once all data between organizations is merged
    @dive_centers.each_with_object(Hash.new(0)) { |obj, counts| counts[obj.training_organizations.first.short_name] += 1 }
  end

  def filter
    @dive_centers = [@dive_centers.first]
  end
end
