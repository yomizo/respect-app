require 'rails_helper'

RSpec.describe Post, type: :model do
  
  # respect, lat, lng, user_id があれば有効
  it "is valid with respect, lat, lng and user_id" do
    # before_action authentication

    post = Post.new(
      respect: 1,
      lat: 35.3242,
      lng: 139.4321,
    )
    expect(post).to be_valid
  end
end
