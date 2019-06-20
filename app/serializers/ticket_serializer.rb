class TicketSerializer < ActiveModel::Serializer
  attributes :id,:venue_event_id, :bought
end
