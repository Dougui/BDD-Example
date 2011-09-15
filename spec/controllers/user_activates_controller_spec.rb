require 'spec_helper'

describe UserActivatesController do

  before (:each) do
    User.destroy_all
    @user = FactoryGirl.create(:user)
  end
  subject {response}

  describe "GET 'new'" do
    before (:each) {get :new, :id => @user.perishable_token}
    it {should redirect_to "/login"}
  end

end
