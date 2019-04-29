class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_name, :token
end
