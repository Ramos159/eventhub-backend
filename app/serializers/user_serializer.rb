class UserSerializer < ActiveModel::Serializer
  attributes :username, :avatar, :tickets, :reviews
end
