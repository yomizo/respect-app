class User < ApplicationRecord
  
  has_secure_token
  has_secure_password

  has_many :posts
  has_many :metoo

  validates :name, :email, presence: true
  validates :email, uniqueness: true

end
