class Dog < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  validates :name, presence: true
  validates :breed, presence: true
  validates :personality, presence: true
  validates :photos, presence: true
  validates :date_of_birth, presence: true

  # def self.by_breed_and_personality(breed = nil, personality = nil)
  #   return where(breed: breed, personality: personality) if breed && personality
  #   return where(breed: breed) if breed
  #   return where(personality: personality) if personality
  #   all
  # end

  #Fetch a list of breeds in the database. Run a SQL query which will fetch a DISTINCT list of breeds.
  def get_breeds
    Dog.select(:breed).distinct.map(&:breed)
  end

end
