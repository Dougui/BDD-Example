require 'spec_helper'

describe UsersController do
  setup :activate_authlogic

  before (:each) do
    User.destroy_all
    @user = FactoryGirl.build(:user)
    @user_attributes = FactoryGirl.attributes_for(:user)
  end
  subject {response}
  
  describe "GET 'new'" do
    before (:each) {get :new}
    it {should be_success}
    it {should render_template("users/new")}
  end

  describe "PUT 'create'" do
    context "with valid arguments" do
      before (:each) {post :create, :user => @user_attributes}
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
        put :edit, :user => @user_attributes, :id => @user.id
      end
      it {should be_success}
      it {should render_template("users/edit")}
    end

    context "when unlogged" do
      before (:each) {put :edit, :user => @user_attributes, :id => @user.id}
      should_not_access
    end
  end

  describe "PUT 'update'" do
    context "when logged" do
      before (:each) do
        @user.active = true
        @user.save
        UserSession.create(@user)
      end

      context "with valid arguments" do
        before (:each) {put :update, :user => @user_attributes, :id => @user.id }
        it {should redirect_to "/"}
      end

      context "with invalid arguments" do
        before (:each) do
          @user_attributes[:username] = nil
          put :update, :user => @user_attributes, :id => @user.id
        end
        it {should be_success}
        it {should render_template("users/edit")}
      end
    end

    context "when unlogged" do
      before (:each) { put :update, :user => @user_attributes, :id => @user.id }
      should_not_access
    end
  end

  describe "DELETE 'destroy'" do
    context "when logged" do
      before (:each) do
        @user.active = true
        @user.save
        UserSession.create(@user)
        delete :destroy, :id => @user.id
      end
      it {should redirect_to "/"}
    end

    context "when unlogged" do
      before (:each) { delete :destroy, :id => @user.id }
      should_not_access
    end
  end
end