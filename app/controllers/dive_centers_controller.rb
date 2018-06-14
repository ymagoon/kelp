class DiveCentersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :autocomplete, :search]

  before_action :set_dive_center, only: [:show, :edit, :update]
  before_action :set_location, only: [:update]

  def index
    search = params[:search].present? ? params[:search] : nil
    @dive_centers = DiveCenter.search(search)
  end

  def search
    # Only gather data if its an AJAX call, otherwise render blank HTML
    if request.format == 'application/json'
      search_term = params[:search].present? ? clean_search : ""
      @dive_centers = DiveCenter.search search_term, fields: [:name, :city, :state, :country]

      # instantiate query object
      query = QueryFilter.new(@dive_centers, params)

      # filter based on parameters
      @dive_centers = query.filter

      @training_organization_filters = query.build_training_organization_filters
      @dive_center_type_filters = query.build_dive_center_type_filters
    end

    respond_to do |format|
      format.html
      format.json do
        # json_data = @dive_centers.each { |dc| dc.as_json(include: :location)}
        # puts json_data
        render json: {
          filters: {
            training_organizations: @training_organization_filters,
            dive_center_types: @dive_center_type_filters
          },
          centers: @dive_centers
        }.to_json
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    puts "----------------------"
    puts @location

    if @dive_center.update(permit_validated_data)
      # @dive.center.update(verified: 1)
      redirect_to validate_dive_centers_path
    else
      render 'edit'
    end
  end

  def autocomplete
    render json: DiveCenter.search(params[:query], {
      fields: ['city', 'state', 'country'],
      limit: 10,
      load: false
      })
  end

  def validate
    @dive_centers = DiveCenter.unverified.includes(:location)
  end

  private

  def permit_params
    params.require(:filter).permit(:agency, :city) unless params[:filter].nil?
  end

  def permit_validated_data
    params.require(:dive_center).permit(:name, :primary_phone,
                                        :mobile_phone, :website,
                                        :email, :fax, :tripadvisor,
                                        :fb, :twitter, :youtube,
                                        :google, :linkedin, :blog,
                                        :project_aware)
  end

  def clean_search
    params[:search].gsub(/[!@#$%^&*()\"\'\,\.\\]/,'')
  end

  def set_dive_center
    @dive_center = DiveCenter.find(params[:id])
  end

  def set_location
    @location = @dive_center.location
  end
end
