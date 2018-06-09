class DiveCentersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    search = params[:search].present? ? params[:search] : nil
    @dive_centers = DiveCenter.search(search)
  end

  def show
    @dive_center = DiveCenter.find(params[:id])
  end

  def clean_search
    params[:search] # add regex to remove shit
  end

  def autocomplete
    render json: DiveCenter.search(params[:query], {
      fields: ['name'],
      limit: 10,
      load: false
      }).map(&:name)
  end
end
