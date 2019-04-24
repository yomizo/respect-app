class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :metoo

  validates :name, :email, presence: true
end
