class MooversDatasController < ApplicationController

  layout false

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def show
    @moovers_data = MooversData.find(params[:id])
  end

  def new
    @user_id = params[:id]
    @user = User.find @user_id
    @cv = @user.cvs.first
    if @cv.moovers_data.nil?
      @moovers_data = @cv.create_moovers_data
    else
      @moovers_data = @cv.moovers_data    
    end
    render :action => 'edit'
  end

  def cancel_create
    @user = current_user
    render :partial => "create", :locals => { :user => @user }   
  end

  def edit_title
    @user = User.find params[:id]
    @cv = @user.cvs.first
    if @cv.moovers_data.nil?
      @cv.moovers_data = MooversData.new
    end
    @moovers_data = @cv.moovers_data
  end

  def update_title
    @moovers_data = MooversData.find(params[:id])
    @moovers_data.update_attributes(params[:moovers_data])
    @user = User.find session[:user]
    @cv = @user.cvs.first
  end

  def cancel_update_title
    @moovers_data = MooversData.find(params[:id])
    @user = User.find session[:user]
    @cv = @user.cvs.first
    render  :partial => "cv_title"
  end

  def edit
    @moovers_data = MooversData.find(params[:id])
  end

  def update
    @moovers_data = MooversData.find(params[:id])
    @moovers_data.generate_birth_date(params[:moovers_data])
    @moovers_data.update_attributes(params[:moovers_data])
    @user = User.find session[:user]
    @cv = @user.cvs.first
    render :action => "create"
  end

  def cancel_update
    @moovers_data = MooversData.find(params[:id])
    @user = User.find session[:user]
    @cv = @user.cvs.first
    render  :partial => "show"
  end

  def destroy
    MooversData.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
    
end
