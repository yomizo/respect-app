class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit # permition

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :no_authorization


  # correct token? or have token?
  def authenticate # ninsho
    if request.headers[:HTTP_AUTHORIZATION] != nil
      current_user || no_authentication
    else
      no_header
    end
  end

  private
  # Searching which does user have token?
  def current_user 
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(token: token) 
    end
  end

  def no_header
    render json: { error: 'No Header' }, status: 400
  end

  def no_authentication # no_ninsho
    render json: { error: 'No Authentication' }, status: 401
  end

  def no_authorization # no_ninka
    render json: { error: 'No Authorization' }, status: 403
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: 404
  end
end
