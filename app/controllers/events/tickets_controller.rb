class Events::TicketsController < ApplicationController

  filter_resource_access :nested_in => :events

  def index
    @tickets = @event.tickets.all
  end

  def show
    @ticket = @event.tickets.find(params[:id])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = @event.tickets.build(params[:ticket])
    @ticket.available = @ticket.capacity
    @ticket.status = 'on-sale'
    if @ticket.save
      #todo 启动异步JOB, 在指定时间开售
      redirect_to event_tickets_path(@event)
    else
      render 'new'
    end
  end

  def edit
    @ticket = @event.tickets.find(params[:id])
  end

  def update
    @ticket = @event.tickets.find(params[:id])

    if @ticket.update_attributes(params[:ticket])
      redirect_to event_tickets_path(@event)
    else
      render :action => :new
    end

  end

  def destroy
    @ticket = @event.tickets.find(params[:id])
    @ticket.destroy

    redirect_to event_tickets_path(@event)
  end

  def show
    @ticket = @event.tickets.find(params[:id])
  end
end
