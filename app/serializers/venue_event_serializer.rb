class VenueEventSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :venue_id, :sale_info, :pricing_info, :event_info, :on_sale,:reviews
end

# def reviews
#   puts"here"
#   Review.where(venue_event_id: @options[:venue_event].id).map do |review|
#     ReviewSerializer.new(review)
#   end
# end
