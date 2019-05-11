module V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy] # need to authorization
    before_action :authenticate, except: [:create] # need to authenticate
    

    def index
      users = User.all
      render json: users, adapter: :json
    end

    def show
      image_link = url_for(@user.avatar_image) if @user.avatar_image.attached?
      render json: {name: @user.name, email: @user.email, image: image_link}, adapter: :json
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: {id: user.id, token: user.token}, adapter: :json, status: 201
      else
        render json: { error: user.errors}, status: 422
      end
    end

    def update
      if @user.update(user_params)
        @user.avatar(user_params[:image])
        render json: @user, adapter: :json, status: 200
      else
        render json: { error: @user.errors }, status: 422
      end
    end

    def destroy
      @user.destroy
      head 204
    end

    private

    def set_user
      @user = User.find(params[:id])
      authorize @user # pundit_helper
    end

    # permition
    def user_params
      params.require(:user).permit(:name, :email, :password, :image)
    end
  end
end