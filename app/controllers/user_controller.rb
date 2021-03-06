class UserController < ApplicationController



  def create
    user = User.new(
      username:params["Username"],
      password:params["Password"],
      email:params["Email"],
      avatar:nil
    )

    if user.save
      token = encode_token(user)
      render json: {
        username:user.username,
        avatar:user.avatar,
        tickets:create_user_tickets(user.id),
        reviews:create_user_reviews(user.id),
        token: token
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
    render json: {
      username:user.username,
      avatar:user.avatar,
      tickets:create_user_tickets(user.id),
      reviews:create_user_reviews(user.id)
    }
    # render json: user
  end

  def destroy
    user=User.find(params[:id])
    user.destroy
    render json: {response:"user deleted"}
  end

  def edit
  end

  def create_user_reviews(id)
    user = User.find(id)
    obj={}
    user.reviews.each do |review|
      obj[review.id] = review
    end
    obj
  end

  def create_user_tickets(id)
    user = User.find(id)
    obj={}
    user.tickets.each do |ticket|
      obj[ticket.id] = ticket
    end
    obj
  end

end
