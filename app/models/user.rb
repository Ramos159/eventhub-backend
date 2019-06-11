class User < ApplicationRecord
  has_many :tickets
  has_many :reviews
  has_many :venue_events, through: :tickets
  validates :username, presence: true , uniqueness: true
  validates :password_digest, presence: true
  validates :email, presence: true , uniqueness: true
  has_secure_password
end
