class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name,:address_info,:box_office_info,:images
end
