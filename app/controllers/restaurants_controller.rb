class RestaurantsController < ApplicationController

  def index
    limit = params[:limit] || 10
    sorting = params[:sort] || "descending"
    if params[:query]
      @restaurants = Restaurant.search(params[:query],limit, sorting)
    else
      @restaurants = Restaurant.sort_by_average_score(limit, sorting)
    end
  end

  def show
    @rest = Restaurant.find_by_id(params[:id])
  end
end
