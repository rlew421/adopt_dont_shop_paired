class Pet < ApplicationRecord
  validates_presence_of  :image,
                         :name,
                         :approximate_age,
                         :sex,
                         :description
  validates_inclusion_of :adoptable?, :in => [true, false]
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def self.sort_pets_by_status
    Pet.order(adoptable?: :desc)
  end

  def applicant_name(pet_id)
    pet = Pet.find(pet_id)
    pet.application_pets.where(approved?: true).first.application.name
  end
end
