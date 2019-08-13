class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :user,:venue_event, :rating, :body
end
