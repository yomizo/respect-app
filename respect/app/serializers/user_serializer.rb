class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :password_digest, :email, :image_name, :api_key
end
