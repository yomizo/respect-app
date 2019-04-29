class Post < ApplicationRecord
  has_many :metoos, foreign_key: :post_id, dependent: :destroy
  belongs_to :user

  validates :respect, :lat, :lng, presence: true
  
  # thanks=>0 cheer=>1
  enum respect: %i( thanks cheer)
end
