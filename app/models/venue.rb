class Venue < ApplicationRecord
  has_many :venue_events
  has_many :events, through: :venue_events
end
