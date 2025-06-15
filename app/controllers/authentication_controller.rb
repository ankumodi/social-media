class AuthenticationController < ApplicationController

  skip_before_action :authenticate_user, only: [:login]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def login 
      @user = User.find_by!(email: login_params[:email])
      if @user && @user.authenticate(login_params[:password])
          @token = encode_token(user_email: @user.email)
          render json: {
          #    user: UserSerializer.new(@user),
              user: @user,
              token: @token
          }, status: :accepted
      else
          render json: {message: 'Incorrect credential'}, status: :unauthorized
      end

  end

  private 

  def login_params 
    params.require(:user).permit(:email, :password)
  end

  def handle_record_not_found(e)
      render json: { message: "User doesn't exist" }, status: :unauthorized
  end
end