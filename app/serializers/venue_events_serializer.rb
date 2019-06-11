class VenueEventsSerializer < ActiveModel::Serializer
  attributes :id, :event, :venue, :on_sale
end
