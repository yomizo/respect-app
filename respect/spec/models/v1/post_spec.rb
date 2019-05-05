require 'rails_helper'

RSpec.describe Post, type: :model do

  # 前提postを作成
  before "generates associated data from a factory" do
    @post = FactoryBot.create(:post)
  end


  # 
  describe "validation" do
    # 正常系
    context "valid" do
      # respect, lat, lng, user_id があれば有効
      it "is valid with respect, lat, lng and user_id" do
        expect(@post).to be_valid
      end

      # comment がなくても有効
      it "is valid without comment" do
        @post.comment = nil
        expect(@post).to be_valid
      end
    end


    #　異常系
    context "invalid" do
      # respect が無ければ無効 
      it "is invalid without respect" do
        @post.respect = nil
        expect(@post).to_not be_valid
      end

      # lat が無ければ無効 
      it "is invalid without lat" do
        @post.lat = nil
        expect(@post).to_not be_valid
      end

      # lng が無ければ無効 
      it "is invalid without lng" do
        @post.lng = nil
        expect(@post).to_not be_valid
      end

      # user_id が無ければ無効 
      it "is invalid without user_id" do
        @post.user_id = nil
        expect(@post).to_not be_valid
      end
    end
  end

end
