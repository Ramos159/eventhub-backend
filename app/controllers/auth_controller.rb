class AuthController < ApplicationController
  def login

    user = User.find_by(username: params["Username"])
    if user && user.authenticate(params["Password"])
      token = encode_token(user)
      render json: {user: UserSerializer.new(user), token: token}
    else
      render json: {errors: "You entered wrong username or password!"}
    end

  end

  def autologin
    user = session_user
    if user
      render json: user
    else
      render json: {errors: "Auto Login did not work! please log in manually"}
    end
  end


end
