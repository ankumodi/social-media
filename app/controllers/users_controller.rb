class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create, :show]

  def create 
      @user = User.create!(user_params)
      @token = encode_token(user_email: @user.email)
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

  def show
    user = User.find(params[:id])
    render json: ActiveModelSerializers::SerializableResource.new(user, each_serializer: PostSerializer).as_json

  end

  private
  def user_params 
    params.require(:user).permit(:username, :password, :email)
  end


end