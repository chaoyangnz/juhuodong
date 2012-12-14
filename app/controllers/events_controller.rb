# -*- encoding : utf-8 -*-
class EventsController < ApplicationController
  filter_resource_access :no_attribute_check => [:index, :new, :create]
  # These are the default options for this controller
  #filter_resource_access
  #    :collection => :index,
  #    :new          => [:new, :create],
  #    :member       => [:show, :edit, :update, :destroy],
  #    :nested_in    => nil,
  #    :context      => :conferences,
  #    :no_attribute_check => :index
  #
  # The filter_resource_access is equivalent to the following filter_access_to
  # calls:
  #
  # Before filter to provide the objects for the actions where no params[:id]
  # is available.  See TalksController for a case where this makes sense even
  # for the index action.
  #before_filter :load_conference, :only => [:show, :edit, :update, :destroy]
  #before_filter :new_conference, :only => [:new, :create]
  # Installs a before_filter to check accesses on all actions for the user's
  # authorization.  :attribute_check causes the object in @conference to
  # be checked against the conditions in the authorization rules.
  #filter_access_to :all, :attribute_check => true
  #filter_access_to :index, :attribute_check => false

  skip_filter :authenticate_user!, :only => [:show]

  # 活动Dashboard
  def index
    @events = Event.where(:user_id => current_user.id).order("created_at desc")
  end

  # 创建活动
  def new
    @ticket = @event.tickets.new
  end

  # 创建活动保存
  def create
    @event = Event.new(params[:event])
    @event.user = current_user
    @event.status = params[:action_save_draft] ? 'draft' : 'published'

    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def approve
    @event = Event.find(params[:id])
    Event.approve(@event)
  end

  def edit

  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    @event.destroy

    redirect_to events_path
  end

  def show
    response.headers['Expires'] = '-1'
    response.headers['Cache-Control'] = 'no-cache, no-store'
  end

  # 活动搜索
  def search
    render 'event/search', :layout => 'default'
  end

  # 活动搜索提交
  def search_post

  end
end