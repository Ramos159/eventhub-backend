class VenueEvent < ApplicationRecord
  belongs_to :event
  belongs_to :venue
  has_many :reviews
  has_many :users, through: :reviews
  has_many :tickets
  has_many :users, through: :tickets
end
