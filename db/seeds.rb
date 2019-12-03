# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Shelters
boulder_bulldog_rescue = Shelter.create(name: "Boulder Bulldog Rescue", address: "2712 Slobber Circle", city: "Boulder", state: "CO", zip: 80205)
howlz_n_jowlz = Shelter.create(name: "Howlz 'n Jowlz", address: "7943 Furry Friend Drive", city: "Colorado Springs", state: "CO", zip: 80207)
fantastic_beasts = Shelter.create(name: "Fantastic Beasts", address: "9872 Hogwarts Lane", city: "New York City", state: "NY", zip: 10001)

# Pets
harry = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/aa/38/27/aa38272dbdb0b6ee03c17420b7de3c2c.jpg",
  name: 'Harry',
  description: "The most beautiful underbite you've ever seen!",
  approximate_age: 6,
  sex: 'Male',
  adoptable?: false)

tater_tot = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/ac/4c/3f/ac4c3f848136a5f59b973943c113723f.jpg",
    name: 'Tater Tot',
    description: "The cutest potato!",
    approximate_age: 8,
    sex: 'Female',
    adoptable?: false)

henri = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/59/71/31/5971314eb28926a1ccc298396f099189.jpg",
                    name: 'Henri',
                    description: "With his heartwarming wrinkles and furrowed brow, he'll slobber his way into your heart!",
                    approximate_age: 5,
                    sex: 'Male')

alfred = howlz_n_jowlz.pets.create(image: "https://scontent-den4-1.xx.fbcdn.net/v/t31.0-8/14608760_10153942326162816_2748710450820779939_o.jpg?_nc_cat=100&_nc_oc=AQnrfoKEaHR6I5dtefDwT7AGx_jSyJbGEabXvtbS9jMf2eGvl4_plvsK3eSmKjECppM&_nc_ht=scontent-den4-1.xx&oh=358dd965255af229bdc5ea8bb5090fca&oe=5E4AA5BB",
                    name: 'Alfred',
                    description: "Truly a beautiful wrinkly boi!",
                    approximate_age: 2,
                    sex: 'Male')

toast = boulder_bulldog_rescue.pets.create(image: "https://i.pinimg.com/564x/4b/0c/99/4b0c99ace72fdfc65b2853fa14d41a8b.jpg",
                    name: 'Toast',
                    description: "She snorts, she farts, she's sweeter than French toast!",
                    approximate_age: 4,
                    sex: 'Female')

carl = fantastic_beasts.pets.create(image: "https://miro.medium.com/max/2560/1*TikCoIz1qOJ9iyFMJ_MBiQ.jpeg",
                    name: 'Carl',
                    description: "Is he a rodent? Is he a fish? We're honestly not sure. Adopt him today!",
                    approximate_age: 2,
                    sex: 'Male',
                    adoptable?: false)

stitch = fantastic_beasts.pets.create(image: "https://data.whicdn.com/images/67819045/superthumb.jpg?t=1373471970",
                    name: 'Stitch',
                    description: "We found him under a truck this morning.",
                    approximate_age: 1,
                    sex: 'Male')

fred = fantastic_beasts.pets.create(image: "https://townsquare.media/site/723/files/2015/04/Pet-Rock-12.jpg?w=980&q=75",
                    name: 'Fred',
                    description: "Sedentary, sedimentary, and perfectly low-maintenance. Safe to say he won't run away!",
                    approximate_age: 5700,
                    sex: 'Male',
                    adoptable?: false)
