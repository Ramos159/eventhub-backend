class User < ApplicationRecord
  has_secure_password
  has_many :tickets
  has_many :reviews
  has_many :venue_events, through: :tickets
end
