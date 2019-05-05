require 'rails_helper'

RSpec.describe "Users", type: :request do
  before "generate test_user" do
    @user = FactoryBot.create(:user, name: "request_user")
    @user_params = FactoryBot.attributes_for(:user)
  end

  #
  describe "GET /user" do
    # header　なしの リクエスト(400)
    it "GET user index unworks! without header" do
      get "/users"
      expect(response).to have_http_status(400)
    end

    # header に ニセトークン(401)
    it "GET user index unworks! with wrong token" do
      get "/users", headers: { 'Authorization' => "Token token=wrongtoken"}
      expect(response).to have_http_status(401)
    end

    # index リクエストOK(200)
    it "GET user index works!" do
      get "/users", headers: { 'Authorization' => "Token token=#{@user.token}"}
      expect(response).to have_http_status(200)
    end

    # 自分の show リクエストOK(200)
    it "GET user's show works!" do
      get "/users/#{@user.id}", headers: { 'Authorization' => "Token token=#{@user.token}"}
      expect(response).to have_http_status(200)
    end

    # 他人の show リクエストOK(200)
    it "GET other_user's show works!" do
      other_user = FactoryBot.create(:user)
      get "/users/#{other_user.id}", headers: { 'Authorization' => "Token token=#{@user.token}"}
      expect(response).to have_http_status(200)
    end
  end

  #
  describe "POST /user" do
    # 新規登録 OK(201)
    it "POST user create works!" do
      new_user_params = FactoryBot.attributes_for(:user, name: "new_user")
      post "/users", params: {user: new_user_params}
      expect(response).to have_http_status(201)
    end
  end

  # 
  describe "DELETE /user" do
    # 自分の delete(204)
    it "DELETE user works!" do
      delete "/users/#{@user.id}", headers: { 'Authorization' => "Token token=#{@user.token}"}
      expect(response).to have_http_status(204)
    end
    # 他人の delete(403)
    it "DELETE other_user unworks!" do
      other_user = FactoryBot.create(:user)
      delete "/users/#{other_user.id}", headers: { 'Authorization' => "Token token=#{@user.token}"}
      expect(response).to have_http_status(403)
    end
  end

  #
  describe "PATCH /user" do
    # 自分の update OK(200)
    it "PATCH user works!" do
      @user_params = FactoryBot.attributes_for(:user, name: "update_name")
      patch "/users/#{@user.id}", 
        headers: { 'Authorization' => "Token token=#{@user.token}"},
        params: {user: @user_params}
      expect(response).to have_http_status(200)
    end
    # 他人の update(403)
    it "PATCH other_user unworks!" do
      @user = FactoryBot.create(:user, name: "new_user")
      other_user = FactoryBot.create(:user)
      patch "/users/#{other_user.id}", headers: { 'Authorization' => "Token token=#{@user.token}"}
      expect(response).to have_http_status(403)
    end
  end  
end
