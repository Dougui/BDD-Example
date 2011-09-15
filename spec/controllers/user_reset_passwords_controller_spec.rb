#encoding=utf-8
require 'spec_helper'

describe UserResetPasswordsController do
  setup :activate_authlogic

  before (:each) do
    User.destroy_all
    @user = FactoryGirl.create(:user)
    @user_attributes = FactoryGirl.attributes_for(:user)
    @user.save
  end
  subject {response}

  describe "GET 'new'" do
    before (:each) {get :new}
    it {should be_success}
    it {should render_template("user_reset_passwords/new")}
  end

  describe "PUT 'create'" do
    context "with valid arguments" do
      before (:each) {post :create, :user => @user.attributes}
      it {should redirect_to "/login"}
    end

    context "with invalid arguments" do
      before (:each) {post :create, :user => {}}
      it {should be_success}
      it {should render_template("/")}

    end
  end

  describe "GET 'edit'" do
    context "when logged" do

      before (:each) do
        @user.active = true
        @user.save
        UserSession.create(@user)
        get :edit, :id => @user.perishable_token
      end

      context "with valid id" do
        it {should be_success}
        it {should render_template("user_reset_passwords/edit")}
      end
    end

    context "when unlogged" do
      before (:each) {get :edit, :id => @user.perishable_token}
      should_not_access
    end
  end

end
