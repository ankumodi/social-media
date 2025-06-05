class ApplicationController < ActionController::API
  before_action :authenticate_user

  def encode_token(payload)
    JWT.encode(payload, 'hellomars1211') 
  end

  private 
  def authenticate_user
    header = request.headers['Authorization']
    puts 'aaa header'
    puts header
    token = header.split(' ').last if header  # Fix the syntax issue here
    puts 'token'
    puts token
    begin
      @decoded = JWT.decode(token, 'hellomars1211', true, algorithm: 'HS256')
      puts 'decode'
      puts @decoded
      payload = @decoded[0]
      @current_user = User.find_by!(username: payload['user_username'])
      puts 'aaacurent user'
      puts @current_user
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e  # Use correct case for DecodeError
      render json: { error: e.message }, status: :unauthorized 
    end
  end

end
