class PostSerializer < ActiveModel::Serializer
  attributes :id, :user, :respect, :lat, :lng, :comment, :created_at

  # # override
  # def user
  #   return unless object.user
  #   instance_options[:without_serializer] ? object.user : UserSerializer.new(object.user, without_serializer: true)
  # end
 
end
