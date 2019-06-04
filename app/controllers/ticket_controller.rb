class TicketController < ApplicationController
  def create
    ticket = Ticket.new(user_id:params[:user_id],venue_event_id:params[:venue_event_id])
    if ticket.save
        render json:{TicketSerializer.new(ticket)}
    else
      render json:{error:'ticket didnt save!'}
  end

  def index
    tickets = Ticket.all
    render json: tickets
  end

  def show
    ticket = Ticket.find(params[:id])
    render json: ticket
  end

  def destroy
    user = session_user
      ticket = Ticket.find(params[:id])
      if ticket.destroy
        render json:{message:'ticket destroyed'}
      else
        render json:{error:'ticket didnt delete!'}
  end

end
