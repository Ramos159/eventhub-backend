class TicketController < ApplicationController

  def create
    ticket = Ticket.new(user_id:params["UserID"],venue_event_id:params["venueEventID"])
    user = User.find_by(id:params["UserID"])
    if ticket.save
        render json:{user:UserSerializer.new(user)}
    else
      render json:{error:'ticket didnt save!'}
    end

  end

  def purchase
    ticket = Ticket.find(params[:id])
    user = User.find_by(id:params["UserID"])
    if ticket.update(id:params[:id],bought:true)
        render json:{user:UserSerializer.new(user)}
    else
      render json:{error:'ticket didnt save!'}
    end
  end
  # def index
  #   tickets = Ticket.all
  #   render json: create_ticket_obj
  # end
  #
  # def create_ticket_obj
  #   obj = {}
  #   Ticket.all.each do |event|
  #     obj[event.id] = event
  #   end
  #   obj
  # end
  #

  # def show
  #   ticket = Ticket.find(params[:id])
  #   render json: ticket
  # end

  def destroy
    # user = session_user
    ticket = Ticket.find(params[:id])
    user = User.find_by(id:params["UserID"])
    if ticket.destroy
      render json:{user:UserSerializer.new(user)}
    else
      render json:{error:'ticket didnt delete!'}
    end
    end

end
