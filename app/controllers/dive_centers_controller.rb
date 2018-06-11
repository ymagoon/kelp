class DiveCentersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :autocomplete, :search]

  def index
    search = params[:search].present? ? params[:search] : nil
    @dive_centers = DiveCenter.search(search)
  end

  def search
    search_term = params[:search].present? ? clean_search : ""
    @dive_centers = DiveCenter.search(search_term)

    query = QueryFilter.new(@dive_centers, permit_params)

    # @dive_centers = query.filter
    # @locations = query.build_filter(@dive_centers)
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
