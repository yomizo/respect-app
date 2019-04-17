class User < ApplicationRecord
  has_many :posts
  has_many :metoo

  validates :name, :password, :email, presence: true
end
