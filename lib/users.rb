def current_user_session
  return @current_user_session if defined?(@current_user_session)
  @current_user_session = UserSession.find
end

def current_user
  return @current_user if defined?(@current_user)
  @current_user = current_user_session && current_user_session.record
end

def restrict_access
  unless current_user
    redirect_to root_path, :notice => t('access_denied', :scope => 'application_controller')
  end
end

def load_user_using_perishable_token
  @user = User.find_by_perishable_token(params[:id])
  unless @user
    redirect_to root_url, :notice => t('perishabletoken_not_valid', :scope => 'application_controller')
  end
end