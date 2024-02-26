class Dog < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  validates :name, presence: true
  validates :breed, presence: true
  validates :personality, presence: true
  validates :photos, presence: true
  validates :date_of_birth, presence: true
end
