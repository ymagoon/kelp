class DiveCentersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :autocomplete, :search]

  def index
    search = params[:search].present? ? params[:search] : nil
    @dive_centers = DiveCenter.search(search)
  end

  def search
    search_term = params[:search].present? ? clean_search : ""
    @dive_centers = DiveCenter.search search_term, includes: [:location, :training_organizations] # this needs to work for api call

    # instantiate query object
    query = QueryFilter.new(@dive_centers, params)

    # filter based on parameters
    @dive_centers = query.filter

    @training_organization_filters = query.build_training_organization_filters

    respond_to do |format|
      format.html
      format.json do
        # json_data = @dive_centers.each { |dc| dc.as_json(include: :location)}
        # puts json_data
        render json: {
          filters: {
            training_organizations: @training_organization_filters
          },
          centers: @dive_centers #json_data
        }.to_json
      end
    end
  end

  def show
    @dive_center = DiveCenter.find(params[:id])
  end

  def autocomplete
    render json: DiveCenter.search(params[:query], {
      fields: ['name'],
      limit: 10,
      load: false
      }).map(&:name)
  end

  private

  def permit_params
    params.require(:filter).permit(:agency, :city) unless params[:filter].nil?
  end

  def clean_search
    params[:search].gsub(/[!@#$%^&*()\"\'\,\.\\]/,'')
  end

end
