#encoding=utf-8
class UserResetPasswordsController < ApplicationController

  before_filter :restrict_access, :only => [:edit, :update]

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user
      @user.reset_perishable_token!
      UserMailer.reset_password(@user).deliver
      redirect_to(login_path, :notice => t("successfully_created", :scope => 'user_reset_passwords.controller'))
    else
      @user = User.new(:email => params[:user][:email])
      @user.valid?
      unless @user.errors[:email].any?
        @user.errors[:email] = t("unknown_email", :scope => 'user_reset_passwords.controller')
      end
      render :new
    end
  end

  def edit
    @user = User.find_by_perishable_token params[:id]
  end

  def update
    @user = User.find_by_perishable_token params[:id]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      redirect_to(root_path, :notice => t("successfully_updated", :scope => 'user_reset_passwords.controller'))
    else
      render :edit
    end
  end

end
