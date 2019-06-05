class EventSerializer < ActiveModel::Serializer
  attributes :id, :name,:on_sale,:classifications,:images
end
