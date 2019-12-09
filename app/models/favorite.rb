class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Array.new
  end

  def total_count
    @contents.count
  end

  def add_pet(pet)
    @contents << pet
  end

  def remove_pet(pet_id)
    @contents.delete(pet_id)
  end

  def included_in_favorites?(pet_id)
    contents.include?(pet_id)
  end
end
