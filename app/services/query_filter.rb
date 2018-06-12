class QueryFilter
  def initialize(dive_centers, params)
    @dive_centers = dive_centers
    @params = params
  end

  def build_training_organization_filters
    count_by { |center| center.training_organizations.first.short_name }
  end

  def build_dive_center_type_filters
    count_by { |center| center.dive_center_type }
  end

  def filter
    if @params['PADI'].present? && @params['PADI'] == 'true'
      @dive_centers = @dive_centers.select { |dc| dc.training_organizations.map(&:short_name).include? 'PADI' }
    end

    if @params['SDI'].present? && @params['SDI'] == 'true'
      @dive_centers = @dive_centers.select { |dc| dc.training_organizations.map(&:short_name).include? 'SDI' }
    end

    if @params['SSI'].present? && @params['SSI'] == 'true'
      @dive_centers = @dive_centers.select { |dc| dc.training_organizations.map(&:short_name).include? 'SSI' }
    end

    @dive_centers
  end

  private

  def count_by
    @dive_centers.each_with_object(Hash.new(0)) { |obj, h| h[yield(obj)] += 1 }
  end
end
