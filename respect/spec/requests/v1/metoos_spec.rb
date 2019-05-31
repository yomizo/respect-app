require 'rails_helper'

RSpec.describe "Metoos", type: :request do
  before "generates associated data from a factory" do
    # @user = FactoryBot.create(:user)
    # @post = FactoryBot.create(:post)
    @metoo = FactoryBot.create(:metoo)
    # @metoo_params = {user_id: @user.id, post_id: @post.id}
    @metoo = FactoryBot.attributes_for(:metoo)
  end

  #
  describe "GET /metoos" do
    # header なし index リクエストOK(200)
    it "GET metoos index works! without header" do
      get "/metoos"
      expect(response).to have_http_status(200)
    end

    # header なし show リクエストOK(200)
    it "GET metoos show works! without header" do
      get "/metoos/#{@metoo.id}"
      expect(response).to have_http_status(200)
    end
  end

  #
  describe "POST /metoo" do
    # header なしの create  リクエスト(400)
    it "POST metoo create unworks! without header" do
      post "/metoos", params: {metoo: @metoo_params}
      expect(response).to have_http_status(400)
    end

    # create  リクエスト(201)
    it "POST metoo create works! with header" do
      post "/metoos",
        headers: { 'Authorization' => "Token token=#{@metoo.user.token}"},
        params: {metoo: @metoo_params}
      expect(response).to have_http_status(201)
    end

    # header に　ニセトークン(401)
    it "POST metoo create unworks! with wrong header" do
      post "/metoos",
        headers: { 'Authorization' => "Token token=wrongtoken"},
        params: {post: @metoo_params}
      expect(response).to have_http_status(401)
    end     
  end

  # 
  describe "DELETE /metoo" do
    # puts @metoo
    # 自分のmetoo delete(204)
    it "DELETE metoo works!" do
      delete "/metoos/#{@metoo.id}", headers: { 'Authorization' => "Token token=#{@metoo.user.token}"}
      expect(response).to have_http_status(204)
    end
    # 他人のmetoo delete(403)
    it "DELETE other_user_metoo unworks!" do
      other_user_metoo = FactoryBot.create(:metoo)
      delete "/metoos/#{other_user_metoo.id}", headers: { 'Authorization' => "Token token=#{@metoo.user.token}"}
      expect(response).to have_http_status(403)
    end
  end

  #
  # describe "PATCH /metoo" do
  #   # 自分のmetoo update OK(200)
  #   it "PATCH metoo works!" do
  #     @metoo_params = FactoryBot.attributes_for(:metoo)
  #     patch "/metoos/#{@metoo.id}", 
  #       headers: { 'Authorization' => "Token token=#{@metoo.user.token}"},
  #       params: {metoo: @metoo_params}
  #     expect(response).to have_http_status(200)
  #   end
  #   # 他人のmetoo update(403)
  #   it "PATCH other_user_metoo unworks!" do
  #     other_user_metoo = FactoryBot.create(:metoo)
  #     patch "/metoos/#{other_user_metoo.id}", headers: { 'Authorization' => "Token token=#{@metoo.user.token}"}
  #     expect(response).to have_http_status(403)
  #   end
  # end  
end
