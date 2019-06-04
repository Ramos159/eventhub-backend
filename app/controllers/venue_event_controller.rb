class VenueEventController < ApplicationController
  def index
    venue_events = VenueEvent.all
    render json: venue_events
  end

  def show
    venue_event=VenueEvent.find(params[:id])
    render json:venue_event
  end
  
end
