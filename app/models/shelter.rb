class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

  def pet_count
    pets.count
  end

  def average_rating
    reviews.average(:rating).to_f
  end

  def application_count
    pets.joins(:application_pets).count
  end

  def any_pending_pets?
    pending = self.pets.where(adoptable?: false)
    return false if pending.length == 0
  else
    return true
  end
end
