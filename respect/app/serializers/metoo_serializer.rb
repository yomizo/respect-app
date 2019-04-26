class MetooSerializer < ActiveModel::Serializer
  attributes :id, :user, :post

  # override limitation user_info
  def user 
    return unless object.user
    instance_options[:without_serializer] ? object.user : UserSerializer.new(object.user, without_serializer: true)
  end  
end
