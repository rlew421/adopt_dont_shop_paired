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
end
