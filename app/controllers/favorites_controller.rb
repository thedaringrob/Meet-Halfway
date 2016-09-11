class FavoritesController < ApplicationController
  include PlacesHelper
  include MapsHelper

	def create
    @client = GooglePlaces::Client.new(ENV["googleWebAPI"])

    user = current_user.id
	 	place = params["place"];
		Favorite.create(user_id: user, place_id: place)
    new_fav = @client.spot(place)
    MapsHelper.push(new_fav)
    @favresults = MapsHelper.get

    respond_to do |format|
      format.js
    end

  end

	def delete


	end

  def delete_fav
    place = Favorite.find_by_place_id(params[:place_id])

    place.destroy

    respond_to do |format|
      delete_fav.js
    end
  end


end
