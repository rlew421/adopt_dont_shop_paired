class ApplicationsController < ApplicationController

  def new
    pet_favorites = favorites.contents
    @favorited_pets = pet_favorites.map do |pet_id|
      Pet.find(pet_id)
    end
  end

  def create
    pet_favorites = favorites.contents
    @favorited_pets = pet_favorites.map do |pet_id|
      Pet.find(pet_id)
    end
    @favorited_pets.each do |pet|
      pet.applications.create(application_params)
    end
    redirect_to '/favorites'
    flash[:success] = 'Your application has been submitted for the selected pets!'
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
