class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :password, :email, :image_name
end
