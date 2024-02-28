require 'faker'

puts 'Destroying existing data'
Booking.destroy_all
Dog.destroy_all
User.destroy_all

puts 'Creating 20 users'
20.times do
  user = User.new(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    photos: "https://source.unsplash.com/random/?portrait&#{rand(1..1000)}",
    password: 'password'
  )
  user.save!
end
puts 'Created 20 users'

puts 'Creating 15 dogs'
15.times do
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
  puts 'Created 15 dogs'

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
