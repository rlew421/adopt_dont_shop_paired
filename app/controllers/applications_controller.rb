class ApplicationsController < ApplicationController

  def new
    pet_favorites = favorites.contents
    @favorited_pets = pet_favorites.map do |pet_id|
      Pet.find(pet_id)
    end
  end

  def show
    @application = Application.find(params[:application_id])
  end

  def create
    checked_pets = Pet.where(id: params[:favorites])
    application = Application.new(application_params)
    if application.save
      checked_pets.each do |pet|
        pet.applications << application
        favorites.remove_pet(pet.id)
      end
      redirect_to '/favorites'
      flash[:success] = 'Your application has been submitted for the selected pets!'
    else
      flash[:error] = application.errors.full_messages.to_sentence
      redirect_to '/applications/new'
    end
  end

  def update_status
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:application_id])
    approved = ApplicationPet.where(pet_id: pet.id, application_id: application.id).first
    pet.update_column(:adoptable?, false)
    approved.update_column(:approved?, true)
    redirect_to "/pets/#{pet.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
