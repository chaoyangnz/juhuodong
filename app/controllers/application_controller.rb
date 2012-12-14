class ApplicationController < ActionController::Base

  layout 'application'
  respond_to :html, :js
  before_filter :authenticate_user!

  protected

  # patch helper for AJAX redirect
  def redirect_to(options = {}, response_status = {})
    super(options, response_status)
    if request.xhr?
      # empty to prevent render duplication exception
      path = self.location

      self.status = 200
      self.response_body = nil
      #self.location = nil

      logger.info 'When XHR, use browser js for redirect!'

      render :js => "window.location = #{path.to_json}"
    end
  end

  def render_404
    respond_to do |format|
      format.html { render :file => Rails.root.join("public", "404"), :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  # around filter for transaction
  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      begin
        yield
      ensure
        raise ActiveRecord::Rollback
      end
    end
  end

  # split assets collection for each user
  def ckeditor_filebrowser_scope(options = {})
    super({ :assetable_id => current_user.id, :assetable_type => 'User' }.merge(options))
  end

  def ckeditor_pictures_scope(options = {})
    ckeditor_filebrowser_scope(options)
  end

  def ckeditor_attachment_files_scope(options = {})
    ckeditor_filebrowser_scope(options)
  end

  # Cancan example
  #def ckeditor_authenticate
  #  authorize! action_name, @asset
  #end
  #
  ## Set current_user as assetable
  #def ckeditor_before_create_asset(asset)
  #  asset.assetable = current_user
  #  return true
  #end

  # for devise redirect callback

  # default use "user_root_path"
  #def after_sign_out_path_for(resource)
  #end

  # default use session["#{scope}_return_to"]
  #def after_sign_in_path_for(resource)
  #end

  #def after_inactive_sign_up_path_for(resource)
  #  params['next'] ||  '/'
  #end

end