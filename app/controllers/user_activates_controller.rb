class UserActivatesController < ApplicationController

  def new
    @user = User.find_by_perishable_token(params[:id])

    @user.active = true
    @user.save
    redirect_to(login_path, :notice => t("user_activated", :scope => "user_activates.controller"))
  end
  
end
