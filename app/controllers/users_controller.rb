class UsersController < ApplicationController

  before_filter :restrict_access, :only => [:edit, :update, :destroy]
  
  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.activation(@user).deliver
      redirect_to(login_path, :notice => t("successfully_created", :scope => 'users.controller'))
    else
      render :action => "new"
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

      
    if @user.update_attributes(params[:user])
      redirect_to(root_path, :notice => t("successfully_updated", :scope => 'users.controller'))
    else
      render :action => "edit"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(root_path, :notice => t("successfully_destroyed", :scope => 'users.controller'))
  end

end
