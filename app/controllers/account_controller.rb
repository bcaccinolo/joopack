class AccountController < ApplicationController
  
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie, :except => [ :index, :legal ]
  before_filter :login_required, :except => [ :index, :legal, :login, :signup, :forgotten_pwd ]
  
  def index
    begin
      @user = User.find session[:user] unless session[:user].nil?
    rescue ActiveRecord::RecordNotFound
     reset_session
     redirect_back_or_default(:controller => '/account', :action => 'index')
    end
  end

  def show
    @user = User.find_by_login(params[:id])    
    @cv = @user.cvs.first 
    if @cv.nil?
      @cv = @user.cvs.create
    else 
      @moovers_data = @cv.moovers_data
      @avatar = Avatar.find_by_cv_id(@cv.id)
    end
  end
  
  def tag_search
    @tags = User.tag_counts
    @tag_selections = params['tags']
    @tag_selections.each do |id, value|
      if value.empty?
        @tag_selections[id] = "off"
      end
    end
    
    @searched_tags = ""
    @tag_selections.each do |id, value|
      if value == "on"
        @searched_tags << Tag.find(id).name + ", "
      end
    end
    puts @searched_tags
    @users =  User.find_tagged_with(@searched_tags)
    puts YAML::dump(@users)
    
  end
  
  def settings
    @user = User.find session[:user]
  end
  
  def update
    @user = User.find(params[:id])
    
    params[:user] = {}

    case params[:section]
    when "password"
      if (params[:password].blank? || params[:password] != params[:password_confirmation]) 
        flash[:error] = "Les mots de passe ne sont pas identiques !"
        redirect_to :controller => "account", :action => 'settings'
        return
      end
      params[:user][:password] = params[:password]
      params[:user][:password_confirmation] = params[:password_confirmation]
    when "email"
      if params[:email] != @user.email
        params[:user][:email] = params[:email]
      end
    when "subscription"
        params[:user][:newsletter] = params[:newsletter]
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Informations mises à jour avec succès.'
      redirect_to :controller => "account", :action => 'settings'
    else
      flash[:notice] = 'Error!'
      render :controller => "account", :action => 'settings'
    end
  end
  
  
  def login
    if logged_in?
      redirect_to(:action => 'show', :id => current_user.login)
    end
    
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      self.current_user.last_connection = Time.now
      self.current_user.save
      
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = {  :value => self.current_user.remember_token , 
                                  :expires => self.current_user.remember_token_expires_at }
      end
      
      redirect_to(:controller => "/account", :action => 'show', :id => current_user.login)
    else
      flash[:notice] = "Echec de connexion. Try again ;)"
    end
  end
  
  def signup
    @user = User.new(params[:user])
    if request.post?
      params['user']['status'] == "moover"
      begin
        @user.save!
      rescue
        render :action => :signup
        return
      end
      self.current_user = @user # Give the authentication at signup
      
      # UserNotifier.deliver_activation @user
      # UserNotifier.deliver_admin_notify_new_account @user
      
      flash[:notice] = "Merci pour votre inscription.<br>Bonne continuation :)"
      redirect_to "/account/show/#{@user.login}"
    end
  end
  
  def logout
    current_user = self.current_user
    current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Your account had been deleted."
    redirect_back_or_default(:controller => '/account', :action => 'index')
  end

  def delete
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    current_user.destroy
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/account', :action => 'index')
  end

  def activate
    user = User.find_by_activation_code(params[:id])
    if user.nil?
      render :text => "Code d'activation non reconnu."
    else
      user.activate
      flash[:notice] = "Votre compte est activé. Vous pouvez maintenant vous connecter. Bonne continuation :)"
      redirect_to :action => "login"
    end
  end
  
  def forgotten_pwd

    if request.post?

      users = User.find :all, :conditions => ["email = ?", params[:email]]
      
      if users.size == 1
        @user = users.first
        @user.gen_new_password
        UserNotifier.deliver_new_password @user
        
      else
        flash[:notice] = "Email non présent dans la base."
      end

    end
  
  end
  
  def help 
    
  end
  
  def invite
    
  end

  def legal
    
  end
  
end
