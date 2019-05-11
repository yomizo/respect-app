class User < ApplicationRecord
  has_one_attached :avatar_image
  attr_accessor :image

  has_secure_token
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :metoo, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def avatar(image)
    if image.present? || rex_image(image) == ''
      content_type = create_extension(image)
      # data:~の部分を削除
      contents = image.sub %r/data:((image|application)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      filename = Time.zone.now.to_s + '.' + content_type
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
    end
    attach_image(filename)
  end

  private

  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  def attach_image(filename)
    avatar_image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end



