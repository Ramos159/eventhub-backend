class EventController < ApplicationController

  def index
    events = Event.all
    render json: create_event_obj
  end

  def create_event_obj
    obj = {}
    Event.all.each do |event|
      obj[event.id] = event
    end
    obj
  end

  def show
    event=Event.find(params[:id])
    render json:event
  end

end
