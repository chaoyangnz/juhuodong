# 报名表字段设计
class Events::FieldsController < ApplicationController
  before_filter :load_event
  filter_resource_access

  def index
    @fields = @event.fields
    @fields.each do |field|
      field.options = JSON.parse(field.options) unless field.options.nil?
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    fields = params[:fields]
    index = 0
    fields.each do |key, field|
      field.options = field[:options].to_json unless field[:options].nil?
      if key.start_with? 'new'
        Field.create field
      else
        f = Field.find key.to_i
        f.update_attributes field
      end
    end
  end

  protected
  def load_event
    @event = Event.find(params[:event_id])
  end


end