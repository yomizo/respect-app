class MetooSerializer < ActiveModel::Serializer
  attributes :id, :user, :post

  # override
  def user
    return unless object.user
    instance_options[:without_serializer] ? object.user : UserSerializer.new(object.user, without_serializer: true)
  end  

  def post
    return unless object.post
    instance_options[:without_serializer] ? object.post : PostSerializer.new(object.post, without_serializer: true)
  end  

end
