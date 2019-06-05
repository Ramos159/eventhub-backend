class VenueEventController < ApplicationController
  def index
    venue_events = VenueEvent.all
    render json: create_venue_event_obj
  end

  def create_venue_event_obj
    obj = {}
    VenueEvent.all.each do |event|
      obj[event.id] = event
    end
    obj
  end
  # def show
  #   venue_event=VenueEvent.find(params[:id])
  #   render json:venue_event
  # end

end
