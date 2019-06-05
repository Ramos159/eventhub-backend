class UserController < ApplicationController

  def create
    user = User.new(
      username:params[:username],
      password:params[:password]
    )

    if user.save
      # token = encode_token(user)
      render json: {user: UserSerializer.new(user)
        # , token: token
      }
		else
			render json: {errors: user.errors.full_messages}
		end
  end

  def index
    @users=User.all
    render json: @users
  end

  def show
    user=User.find(params[:id])
    render json: user
  end

  def destroy
    user=User.find(params[:id])
    user.destroy
    render json: {response:"user deleted"}
  end

  def edit
  end

end
