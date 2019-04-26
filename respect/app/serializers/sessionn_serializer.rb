class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :api_key
end
