class ApplicationsController < ApplicationController

  def new
    pet_favorites = favorites.contents
    @favorited_pets = pet_favorites.map do |pet_id|
      Pet.find(pet_id)
    end
  end

  def create
    checked_pets = Pet.where(id: params[:favorites])
    application = Application.create(application_params)
    checked_pets.each do |pet|
      pet.applications << application
      favorites.remove_pet(pet.id)
    end
    redirect_to '/favorites'
    flash[:success] = 'Your application has been submitted for the selected pets!'
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
