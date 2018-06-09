class QueryFilter
  def initialize(params)
    @locations = Location.all
    @dive_centers = DiveCenter.all
  end

  def search
    @objects = @objects.where()
  end
end
