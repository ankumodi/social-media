class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create 
      @user = User.create!(user_params)
      @token = encode_token(user_id: @user.id)
      render json: {
      #    user: UserSerializer.new(user), 
          user: @user,
          token: @token
      }, status: :created
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  private

  def user_params 
    params.require(:user).permit(:username, :password, :email)
  end

end