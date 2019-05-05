class User < ApplicationRecord
  
  has_secure_token
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :metoo, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, uniqueness: true

end
