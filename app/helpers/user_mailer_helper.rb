module UserMailerHelper
  def link_for_activate(user)
    url = url_for(:controller => :user_activates, :action => :new, :id => user.perishable_token, :only_path => false)
    link_to(url, url)
  end
  
  def link_for_reset_password(user)
    url = url_for(:controller => :user_reset_passwords, :action => :edit, :id => user.perishable_token, :only_path => false)
    link_to(url, url)
  end
end