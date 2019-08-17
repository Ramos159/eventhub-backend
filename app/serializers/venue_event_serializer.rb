class VenueEventSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :venue_id, :sale_info, :pricing_info, :event_info, :on_sale,:reviews
end
