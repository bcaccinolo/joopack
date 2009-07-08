class FeedbacksController < ApplicationController
  
  before_filter :get_user

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  

  def new
    @feedback = Feedback.new
  end

  def create
    
    params[:feedback]['user_id'] = session[:user]
    @feedback = Feedback.new(params[:feedback])
    
    if @feedback.save
      @user = User.find session[:user]
      UserNotifier.deliver_admin_notify_feedback @user
      
      
      flash[:notice] = 'Merci pour votre contribution & bonne continuation :D'
      redirect_to :action => 'new'
    else
      render :action => 'new'
    end
  end

  def admin_list
    @feedback_pages, @feedbacks = paginate :feedbacks, :per_page => 10
    render :action => "list"
  end

  def admin_show
    @feedback = Feedback.find(params[:id])
    render :action => "show"
  end

  def admin_destroy
    Feedback.find(params[:id]).destroy
    redirect_to :action => 'admin_list'
  end


# my only protection to protect these interfaces
protected



      def index
        list
        render :action => 'list'
      end

      def update
        @feedback = Feedback.find(params[:id])
        if @feedback.update_attributes(params[:feedback])
          flash[:notice] = 'Feedback was successfully updated.'
          redirect_to :action => 'show', :id => @feedback
        else
          render :action => 'edit'
        end
      end



  def edit
    @feedback = Feedback.find(params[:id])
  end
  
  private
  
  def get_user
    if (session[:user].nil?)
      redirect_to(:controller => "account", :action => "index") 
      return
    end
    @user = User.find(session[:user])
  end
  
end
