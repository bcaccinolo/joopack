class UserNotifier < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Merci d activer votre nouveau compte '
    @body[:url]  = "http://joopack.com/account/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Bienvenu sur Joopack ! '
  end
  
  def admin_notify_new_account(user)
    @recipients  = "benoit.caccinolo@gmail.com"
    @from        = "no-reply@joopack.com"
    @subject     = "[JooPack] New subscription"
    @sent_on     = Time.now
    @body[:user] = user  
  end
  
  def admin_notify_cv_generation(user)
    @recipients  = "benoit.caccinolo@gmail.com"
    @from        = "no-reply@joopack.com"
    @subject     = "[JooPack] New CV generation request"
    @sent_on     = Time.now
    @body[:user] = user  
  end
  
  def admin_notify_feedback(user)
    @recipients  = "benoit.caccinolo@gmail.com"
    @from        = "no-reply@joopack.com"
    @subject     = "[JooPack] New feedback"
    @sent_on     = Time.now
    @body[:user] = user  
  end
  
  def export_notification(user, url)
    setup_email(user)
    @subject    += 'Votre CV est prêt à être téléchargé'
    @body[:url]  = url
  end
  
  def new_password(user)
    setup_email(user)
    @subject    += 'Votre nouveau mot de passe'
    
  end
    
  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "no-reply@joopack.com"
    @subject     = "[JooPack] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
