class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :token
end
