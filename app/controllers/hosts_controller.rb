class HostsController < ApplicationController
  filter_resource_access :no_attribute_check => [:index, :new, :create]

  skip_filter :authenticate_user!, :only => [:show]

  def index
    @hosts = Host.where(:user_id => current_user.id)
  end

  def new
  end

  def create
    @host.user = current_user
    @host.status = 'uncertified'
    if @host.save
      redirect_to hosts_path
    else
      render 'new'
    end

  end

  def edit

  end

  def update
    respond_to do |format|
      if @host.update_attributes(params[:host])
        format.html { redirect_to hosts_path, notice: 'Host was successfully updated.' }
      else
        format.html { render action: "edit" }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

  end

end
