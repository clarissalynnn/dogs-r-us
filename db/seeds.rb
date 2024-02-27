# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
puts 'Destroying existing data'
Booking.destroy_all
Dog.destroy_all
User.destroy_all

puts 'Creating 5 users'
5.times do
  user = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    photos: "https://source.unsplash.com/random/?portrait&#{rand(1..1000)}",
    password: 'password'
  )
  user.save!
end
puts 'Created 5 users'

puts 'Creating 5 dogs'
5.times do
  dog = Dog.new(
    name: Faker::Fantasy::Tolkien.character,
    breed: Faker::Creature::Dog.breed,
    personality: Faker::Creature::Dog.meme_phrase,
    date_of_birth: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
    photos: "https://source.unsplash.com/random/?dog&#{rand(1..1000)}",
    owner: User.all.sample(1).first
    )
  dog.save!
end
puts 'Created 5 dogs'

puts 'Creating 5 bookings'
5.times do
  booking = Booking.new(
    user: User.all.sample(1).first,
    dog: Dog.all.sample(1).first,
    start_date: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
    end_date: Faker::Date.between(from: '2015-09-26', to: '2015-10-25'),
    status: 'Approved'
  )
  booking.save!
end
puts 'Created 5 bookings'
puts 'Finished creating 5 users, dogs, and bookings'
