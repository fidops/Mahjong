class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ExceptionHandler

  before_action :authenticate_by_token

  private

  def authenticate_by_token
    return if authenticate_with_http_token { |token, _| AccessToken.authenticate_by(token) }

    head :unauthorized
  end
end
