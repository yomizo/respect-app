module V1
  class PostsController < ApplicationController
    before_action :set_post, only: [:update, :destroy]
    before_action :authenticate, except: [:index, :show, :search]

    def index
      posts = Post.order(created_at: :desc).limit(500)
      posts = posts.map do |post|
        user = User.find_by(id: post.user_id)
        user.avatar_image.attached? ? image_link = url_for(user.avatar_image) : image_link = nil
        post = post.attributes
        post.merge(image:image_link, user_name: user.name)
      end

      render json: posts, adapter: :json
    end

    def search
      # filter with latlng & time
      lat_range = (params[:lat].to_f - 1.0)..(params[:lat].to_f + 1.0)
      lng_range = (params[:lng].to_f - 1.0)..(params[:lng].to_f + 1.0)
      posts = Post
      .where(lat: lat_range)
      .where(lng: lng_range)
      .order(created_at: :desc)
      .limit(500)
      # get icon image
      posts = posts.map do |post|
        user = User.find_by(id: post.user_id)
        user.avatar_image.attached? ? image_link = url_for(user.avatar_image) : image_link = nil
        post = post.attributes
        post.merge(image: image_link, user_name: user.name)
      end      
      render json: posts, adapter: :json
    end

    def show
      post = Post.find_by(id: params[:id])
      user = User.find_by(id: post.user_id)
      user.avatar_image.attached? ? image_link = url_for(user.avatar_image) : image_link = nil
      post = post.attributes.merge(image: image_link, user_name: user.name)
      render json: post, adapter: :json
    end

    def create
      post = Post.new(post_params.merge(user_id: current_user.id))
      if post.save
        render json: post, adapter: :json, status: 201
      else
        render json: { error: post.errors }, status: 422
      end
    end

    def update
      if @post.update(post_params)
        render json: @post, adapter: :json, status: 200
      else
        render json: { error: @post.errors }, status: 422
      end
    end

    def destroy
      @post.destroy
      head 204
    end

    private

    def set_post
      @post = Post.find_by(id: params[:id])
      authorize @post
    end
    # permition
    def post_params
      params.require(:post).permit(:respect, :lat, :lng, :comment)
    end
  end
end