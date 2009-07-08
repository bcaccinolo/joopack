class ExportController < ApplicationController

  def index
     @user = User.find(session[:user])
     @user.reload # to force the get of the exprt statuses
     @cv = @user.cvs.first
     @action = @cv.action
  end

  def create_action
    @user = current_user    
    @cv = @user.cvs.first
    code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )

    if params[:type] == "pdf_export"
      @cv.create_pdf_export_action({:action_type => "#{params[:type]}", :status => "WAITING", :date => Time.now, :code => code })      
    elsif params[:type] == "doc_export"
      @cv.create_doc_export_action({:action_type => "#{params[:type]}", :status => "WAITING", :date => Time.now, :code => code })
    elsif params[:type] == "odt_export"    
      @cv.create_odt_export_action({:action_type => "#{params[:type]}", :status => "WAITING", :date => Time.now, :code => code })
    end

    UserNotifier.deliver_admin_notify_cv_generation @user

  render :update do |page|
    page << "$('validation_button').disabled = true"
    page << "new Effect.SlideUp('waiting_status', {queue:'front'} ); new Effect.SlideDown('running_status', {queue:'end'} );"
  end

  end

  def reinitialize
    @user = current_user 
    @cv = @user.cvs.first
    @cv.action.destroy

    render :update do |page|
      page << "$('validation_button').disabled = false"
      page << "new Effect.SlideUp('done_not_taken_status', {queue:'front'} ); new Effect.SlideDown('waiting_status', {queue:'end'} );"
    end

  end
  
  def get_file
    action = Action.find_by_code params[:id]
    action.update_attributes({ :status => "DONE_TAKEN", :date => Time.now })
    file_name = "/tmp/cv_#{action.cv_id}.#{action.action_type.slice(0,3)}"
    
    case action.action_type
    when "pdf_export", "doc_export"
      content_type = "application/octet-stream"
    when "odt_export"
      content_type = "application/vnd.oasis.opendocument.text"
    end
    send_file file_name, :type => content_type
  end

end
