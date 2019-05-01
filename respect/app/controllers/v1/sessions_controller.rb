module V1
  class SessionsController < ApplicationController
    
    def signin
      signin_user = User.find_by(email: signin_params[:email])
      if signin_user&.authenticate(signin_params[:password])
        render json: {id: signin_user.id, token: signin_user.token}, adapter: :json
      else
        render json: {error: 'unauthorization'}, status: 422
      end
      
    end

    private

    def signin_params
      params.require(:user).permit(:email, :password)
    end
  end
end
