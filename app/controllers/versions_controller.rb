class Events::VersionsController < ApplicationController

  # save draft
  def create
    @event = Event.new(params[:event])
    version = Event.version.new
    version.data = @event
    version.action = 'create_draft'
    version.status = @event.host.certified? ? 'auto-accept' : 'pending'

    if version.save

    else

    end
  end

  def update

  end
end