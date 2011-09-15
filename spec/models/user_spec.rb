require 'spec_helper'

describe User do

  before {@user = Factory.build(:user)}
  subject {@user}

  context "with valid arguments" do
    it {should be_valid}
  end

  describe :to_s do
    subject {@user.to_s}
    it ("should return the username for to_s function") {should == @user.username}
  end

  context "when created" do
    context "without password" do
      before {@user = Factory.build(:user, :password => nil)}
      it {should_not be_valid}
    end
  end

  context "when updated" do
    context "with blank password" do
      before {@user.password = ""}
      it {should_not be_valid}
    end
  end
end