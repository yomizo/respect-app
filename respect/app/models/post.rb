class Post < ApplicationRecord
  has_many :metoos
  belongs_to :user

  validates :respect, :lat, :lng, presence: true
  
  # thanks=>0 cheer=>1
  enum respect: %i( thanks cheer)
end
