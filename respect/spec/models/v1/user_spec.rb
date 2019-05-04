require 'rails_helper'

RSpec.describe User, type: :model do

  # バリデーション系
  describe "validation" do

    #　正常系
    context "valid" do
      # name, email, password, があれば有効
      it "is valid with name, email, and password" do
        expect(FactoryBot.build(:user)).to be_valid
      end
    end


    # 異常系
    context "invalid" do
      # name がなければ無効
      it "is invalid without name" do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
    
      # email がなければ無効
      it "is invalid without email" do
        user = FactoryBot.build(:user, email: nil)
        user.valid? # .valid? is method for checking existance
        expect(user.errors[:email]).to include("can't be blank")
      end

      # password がなければ無効
      it "is invalid without password" do
        user = FactoryBot.build(:user, password: nil)
        user.valid? # .valid? is method for checking existance
        expect(user.errors[:password]).to include("can't be blank")
      end

      # 重複した　email　なら無効
      it "is invalid with a duplicate email address" do
        FactoryBot.create(:user, email: "yomiyama@yomiyama.com")
        user = FactoryBot.build(:user, email: "yomiyama@yomiyama.com")
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end
    end
  end



 
end
