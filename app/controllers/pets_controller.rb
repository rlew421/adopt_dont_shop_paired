class PetsController < ApplicationController
  def index
    if params[:shelter_id]
      @shelter = Shelter.find(params[:shelter_id])
      @pets = @shelter.pets.sort_pets_by_status
    else
      @pets = Pet.all.sort_pets_by_status
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = Pet.new(pet_params.merge(shelter_id: shelter.id))
    if pet.save
      flash[:success] = "#{pet.name} has been successfully added!"
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    if pet.save
      flash[:success] = "#{pet.name} Updated Successfully"
      redirect_to "/pets/#{pet.id}"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    favorites.remove_pet(pet.id)
    pet.destroy
    redirect_to '/pets'
  end

  private

  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex)
  end
end
