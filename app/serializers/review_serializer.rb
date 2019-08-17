class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :body, :user
end
