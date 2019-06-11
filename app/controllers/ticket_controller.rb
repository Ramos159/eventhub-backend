class TicketController < ApplicationController

  def create
    ticket = Ticket.new(user_id:params[:user_id],venue_event_id:params[:venue_event_id],bought?:false)
    user = user.find_by(id:params[:user_id])
    if ticket.save
        render json:{UserSerializer.new(user)}
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
    if ticket.destroy
      render json:{message:'ticket destroyed'}
    else
      render json:{error:'ticket didnt delete!'}
    end
end

end
