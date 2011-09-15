#encoding=utf-8
require 'spec_helper'

describe UserSessionsController do
  setup :activate_authlogic

  before (:each) do
    User.destroy_all
    @user = FactoryGirl.create(:user)
    @user.active = true
    @user.save
    @user_attributes = FactoryGirl.attributes_for(:user)

    @attributes = {"username"=>@user.username, "password"=>@user.password}
  end

  describe "GET 'new'" do
    before (:each) {get :new}
    subject {response}
    it {should be_success}
    it {should render_template("user_sessions/new")}
  end

  describe "PUT 'create'" do
    context "with valid arguments" do
      before (:each) { post :create, :user_session => @attributes}
      subject {response}
      it {should redirect_to "/"}
    end

    context "with invalid arguments" do
      before (:each) {post :create, :user_session => {}}
      subject {response}
      it {should be_success}
      it {should render_template("new")}
    end
  end

  describe "DELETE 'destroy'" do
    context "when logged" do
      before (:each) do
        @user.active = true
        @user.save
        UserSession.create(@user)
        delete :destroy
      end
      subject {response}
      it {should redirect_to "/"}
    end

    context "when unlogged" do
      before (:each) do
        delete :destroy
      end
      should_not_access
    end
  end
end