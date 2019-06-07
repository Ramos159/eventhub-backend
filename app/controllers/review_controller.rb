class ReviewController < ApplicationController

  def create
    user=User.find(params[:user_id])
    event=VenueEvent.find(:venue_event_id)
    review = review.new(user_id:user,venue_event_id:event.id,rating:params[:rating],body:params[:body])

    if review.save
      render json: create_review_obj
    else
      render json:{error:'invalid review!'}
    end

  end

  def create_review_obj
    obj = {}
    Review.all.each do |event|
      obj[event.id] = event
    end
    obj
  end

  def index
    reviews = Review.all
    render json: create_review_obj
  end
  #
  # def show
  #   review = Review.find(params[:id])
  # end

  def destroy
    # user = session_user
    review = Review.find(params[:id])
    if review.destroy
      render json: user.reviews
    else
      render json:{error:"couldnt delete review"}
    end


  end



end
