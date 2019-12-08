class FavoritesController < ApplicationController
  def index
    pet_favorites = favorites.contents
    @favorited_pets = pet_favorites.map do |pet_id|
      Pet.find(pet_id)
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites = Favorite.new(session[:favorites])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} has been added to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    session[:favorites].delete(pet.id)
    flash[:notice] = "#{pet.name} has been removed from your favorites!"
    if URI(request.referer).path == "/pets/#{pet.id}"
      redirect_to "/pets/#{pet.id}"
    else URI(request.referer).path == "/favorites"
      redirect_to "/favorites"
    end
  end
end
