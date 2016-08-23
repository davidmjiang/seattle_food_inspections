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
    @url = "https://maps.googleapis.com/maps/api/staticmap?center=#{@rest.latitude},#{@rest.longitude}&zoom=15&size=500x400&markers=color:blue|#{@rest.latitude},#{@rest.longitude}|&key=#{ENV['GOOGLE_MAPS_API_KEY']}"
  end
end
