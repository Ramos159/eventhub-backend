class VenueController < ApplicationController

  def index
    venues = Venue.all
    render json: create_venue_obj
  end

  def create_venue_obj
    obj = {}
    Venue.all.each do |event|
      obj[event.id] = event
    end
    obj
  end
  # def show
  #   venue=Venue.find(params[:id])
  #   render json:venue
  # end
end
