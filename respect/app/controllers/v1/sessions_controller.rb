module V1
  class SessionsController < ApplicationController
    
    def signin
      signin_user = User.find_by(email: signin_params[:email])
      image_link = url_for(signin_user.avatar_image) if signin_user.avatar_image.attached?
      if signin_user&.authenticate(signin_params[:password])
        render json: {
          id: signin_user.id, 
          token: signin_user.token, 
          name: signin_user.name,
          image: image_link
          }, adapter: :json
      else
        render json: {error: "Unauthorized"}, status: 422
      end
      
    end

    private

    def signin_params
      params.require(:user).permit(:email, :password)
    end
  end
end
