class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_by_token

  def create
    unless Administrator.find_by(userid: auth_params[:userid])&.authenticate(auth_params[:password])
      head :not_found and return
    end

    # TODO: session は DB ではなく redis などのキャッシュ系へ置き換える
    administrator = Administrator.find_by(userid: auth_params[:userid])
    administrator.create_access_token unless administrator.access_token

    render json: { id: administrator.id, token: administrator.access_token.to_jwt }, status: :created
  end

  def destroy
    access_token = authenticate_with_http_token { |token, _| AccessToken.authenticate_by(token) }
    access_token.destroy if access_token.present?

    head :ok
  end

  private

  def auth_params
    params.require(:auth).permit(:userid, :password)
  end
end
