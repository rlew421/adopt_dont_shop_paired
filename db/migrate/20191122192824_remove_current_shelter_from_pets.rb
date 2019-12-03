class RemoveCurrentShelterFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :current_shelter, :string
  end
end
