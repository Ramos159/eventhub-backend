class ReviewController < ApplicationController


  def index
    render json: Review.all
  end

  def create

    render json:{message:"you made it here nigga"}
    # user=User.find(params[:user_id])
    # event=VenueEvent.find(:venue_event_id)
    # review = review.new(user_id: user.id,venue_event_id: event.id,rating: params[:reviewRating],body: params[:reviewBody])
    #
    # if review.save
    #   render json: Review.all
    # else
    #   render json:{error:'invalid review!'}
    # end

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
