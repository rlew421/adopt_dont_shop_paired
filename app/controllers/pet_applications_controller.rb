class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
  end
end
