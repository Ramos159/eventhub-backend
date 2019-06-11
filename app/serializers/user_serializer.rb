class UserSerializer < ActiveModel::Serializer
  attributes :id,:username, :avatar, :tickets, :reviews, :email
end
