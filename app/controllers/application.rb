
MONTHS = [
  "Janvier","Février","Mars", "Avril", "Mai", "Juin", "Juillet", 
  "Aout", "Septembre", "Octobre", "Novembre", "Décembre"
]
YEARS = (1950..Time.now.strftime("%Y").to_i).map {|a| a.to_s}.reverse
  

class ApplicationController < ActionController::Base

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  layout "users"

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_new_session_id'

  Locale.set("fr")

  before_filter :set_locale

  def set_locale
    url = request.env['HTTP_HOST']
    unless url.match(/\.fr$/).nil? and url.match(/^fr\./).nil? 
      Locale.set 'fr-FR'          
    else 
      Locale.set 'en-EN'    
    end
    # Locale.set 'fr-FR'          
    # Locale.set 'en-EN'    
  end


  def avatar
    if request.post?
      render :partial => "moovers_datas/edit_avatar"
    else
      render :nothing => true
    end
  end

  def show_avatar_to_delete
    @user = User.find_by_login(params['id'])
    @cv = @user.cvs.first
    @avatar = Avatar.find_by_cv_id(@cv.id)
    render :partial  => "moovers_datas/show_avatar"
  end

  def save_avatar
    user_id = current_user.id
    @user = User.find user_id
    @cv = @user.cvs.first

    if params['id'] != "cancel" and params[:avatar][:uploaded_data] != ""
      begin
        @photos = Avatar.find_all_by_cv_id(@cv.id)
        @photos.each do |photo|
          photo.destroy
        end
      rescue
      end
      params[:avatar]['cv_id'] = @cv.id
      @avatar = Avatar.create!(params[:avatar])
    end
    redirect_to :controller => "account", :action => "show", :id => current_user.login
  end


end
