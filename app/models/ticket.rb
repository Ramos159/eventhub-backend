class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :venue_event
end
