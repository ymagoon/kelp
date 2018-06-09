class QueryFilter
  def initialize(dive_centers, params)
    @dive_centers = dive_centers
    @params = params
  end

  def filter
    @dive_centers = [@dive_centers.first]
  end
end
