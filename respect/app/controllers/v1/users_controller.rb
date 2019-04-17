module V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    
    def index
      users = User.all
      render json: users, adapter: :json
    end

    def show
      render json: @user, adapter: :json
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, adapter: :json, status: 201
      else
        render json: { error: user.errors }, status: 422
      end
    end

    def update
      if @user.update(user_params)
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
    end
    # permition
    def user_params
      params.require(:user).permit(:name, :email, :password, :image_name)
    end
  end
end