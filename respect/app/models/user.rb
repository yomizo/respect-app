class User < ApplicationRecord
  before_create :generate_api_key

  has_secure_password
  has_many :posts
  has_many :metoo

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.base64(30)
      break unless User.exists?(api_key: self.api_key)
    end
  end
end
