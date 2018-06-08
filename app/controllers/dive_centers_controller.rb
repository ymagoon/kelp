class DiveCentersController < ApplicationController
  def index
    @dive_centers = DiveCenter.all # never going to do this actually!
  end

  def show
    @dive_center = DiveCenter.find(params[:id])
  end
end
