require 'rails_helper'

RSpec.describe User, type: :model do

  # name, email, password, があれば有効
  it "is valid with name, email, and password" do
    user = User.new(
      name: "test_user1",
      email: "test@test.com",
      password: "testestestest",
    )
    expect(user).to be_valid
  end

  # name がなければ無効
  it "is invalid without name" do
    user = User.new(name: nil)
    user.valid? # .valid? is method for checking existance
    expect(user.errors[:name]).to include("can't be blank")
  end
 
  # email がなければ無効
  it "is invalid without email" do
    user = User.new(email: nil)
    user.valid? # .valid? is method for checking existance
    expect(user.errors[:email]).to include("can't be blank")
  end

  # password がなければ無効
  it "is invalid without password" do
    user = User.new(password: nil)
    user.valid? # .valid? is method for checking existance
    expect(user.errors[:password]).to include("can't be blank")
  end

  # 重複した　email　なら無効
  it "is invalid with a duplicate email address" do
    User.create(
      name: "test_user1",
      email: "test@test.com",
      password: "dsffafafdsaf",
    )

    user = User.new(
      name: "test_user2",
      email: "test@test.com",
      password: "dsffafafdsaf",      
    )

    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
 
end
