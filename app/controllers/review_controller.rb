class ReviewController < ApplicationController

  def create
    user=User.find(params[:user_id])
    event=VenueEvent.find(:venue_event_id)
    review = review.new(user_id:user,venue_event_id:event.id,rating:params[:rating],body:params[:body])

    if review.save
      render json: review
    else
    render json:{error:'invalid review!'}
  end

  def index
    reviews = Review.all
    render json:reviews
  end

  def show
    review = Review.find(params[:id])
  end

  def destroy
    review = Review.find(params[:id])
    if review.destroy
      render json: {message:"review destroyed"}
  end
end
