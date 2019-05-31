require 'rails_helper'

RSpec.describe Metoo, type: :model do
  # metoo を作成
  before "generates associated data from a factory" do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    @metoo = Metoo.new(user_id: @user.id, post_id: @post.id)
  end

  #
  describe "validation" do
    # 正常系
    context "valid" do
      # user_id, post_id があれば有効
      it "is valid with user_id and post_id" do
        expect(@metoo).to be_valid
      end
    end


    # 異常系
    context "invalid" do
      # user_id が無ければ無効
      it "is invalid without user_id" do
        @metoo.user_id = nil
        expect(@metoo).to_not be_valid
      end

      # post_id が無ければ無効
      it "is invalid without post_id" do
        @metoo.post_id = nil
        expect(@metoo).to_not be_valid
      end
    end
  end
end
