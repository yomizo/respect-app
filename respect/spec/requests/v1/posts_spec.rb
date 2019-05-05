require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before "generate test_post" do
    @post = FactoryBot.create(:post)
    @post_params = FactoryBot.attributes_for(:post)
  end

  #
  describe "GET /posts" do
    # header なし index リクエストOK(200)
    it "GET posts index works! without header" do
      get "/posts"
      expect(response).to have_http_status(200)
    end

    # header なし show リクエストOK(200)
    it "GET posts show works! without header" do
      get "/posts/#{@post.id}"
      expect(response).to have_http_status(200)
    end
  end

  #
  describe "POST /post" do
    # header なしの create  リクエスト(400)
    it "POST post create unworks! without header" do
      post "/posts", params: {post: @post_params}
      expect(response).to have_http_status(400)
    end

    # create  リクエスト(201)
    it "POST post create works! with header" do
      post "/posts",
        headers: { 'Authorization' => "Token token=#{@post.user.token}"},
        params: {post: @post_params}
      expect(response).to have_http_status(201)
    end

    # header に　ニセトークン(401)
    it "POST post create unworks! with wrong header" do
      post "/posts",
        headers: { 'Authorization' => "Token token=wrongtoken"},
        params: {post: @post_params}
      expect(response).to have_http_status(401)
    end     
  end

  # 
  describe "DELETE /post" do
    # 自分の投稿 delete(204)
    it "DELETE post works!" do
      delete "/posts/#{@post.id}", headers: { 'Authorization' => "Token token=#{@post.user.token}"}
      expect(response).to have_http_status(204)
    end
    # 他人の投稿 delete(403)
    it "DELETE other_user_post unworks!" do
      other_user_post = FactoryBot.create(:post)
      delete "/posts/#{other_user_post.id}", headers: { 'Authorization' => "Token token=#{@post.user.token}"}
      expect(response).to have_http_status(403)
    end
  end

  #
  describe "PATCH /post" do
    # 自分の投稿 update OK(200)
    it "PATCH post works!" do
      @post_params = FactoryBot.attributes_for(:post, respect: "cheer")
      patch "/posts/#{@post.id}", 
        headers: { 'Authorization' => "Token token=#{@post.user.token}"},
        params: {post: @post_params}
      expect(response).to have_http_status(200)
    end
    # 他人の投稿 update(403)
    it "PATCH other_user_post unworks!" do
      other_user_post = FactoryBot.create(:post)
      patch "/posts/#{other_user_post.id}", headers: { 'Authorization' => "Token token=#{@post.user.token}"}
      expect(response).to have_http_status(403)
    end
  end  
end
