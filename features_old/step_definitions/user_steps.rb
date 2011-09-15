#encoding=utf-8
Given /^I have no users$/ do
  User.delete_all
end

Given /^I have a valid user$/ do
  User.delete_all
  user = Factory.create(:user)
  user.active = true
  user.save
end


Given /^I should have ([0-9]+) user$/ do |count|
  User.count.should == count.to_i
end

Given /^I am a logged user$/ do
  User.delete_all
  @logged_in_user = Factory.create(:user)
  @logged_in_user.active = true
  @logged_in_user.save
  visit login_path
  fill_in 'user_session_username', :with => @logged_in_user.username
  fill_in 'user_session_password', :with => @logged_in_user.password
  click_button "user_session_submit"
end

Given /^the user ([0-9]+) must have "(.*)" as "(.*)"/ do |id, value, field|
  user = User.find id
  user.send(field).should == value
end

Then /^I couldn't access to (.*)$/ do |page_name|

  if page_name =~ /^the ([a-zA-Z_]*) ([a-zA-Z_]*) page with id (.*) with method (.*)$/
    case $4
    when 'put'
      page.driver.put(path_to("the #{$1} #{$2} page with id #{$3}"))
    when 'delete'
      page.driver.delete(path_to("the #{$1} #{$2} page with id #{$3}"))
    else
      page.driver.post(path_to("the #{$1} #{$2} page with id #{$3}"))
    end
    page.should have_content("Vous devez vous connecter pour accéder à cette page.")
  else
    visit path_to(page_name)
    current_path = URI.parse(current_url).path
    page.should have_content("Vous devez vous connecter pour accéder à cette page.")
    current_path.should == "/"
  end

end
#
#Then /^I couldn't access to (.*) with method (.*)$/ do |page_name, method|
#  method path_to(page_name)
#
#  current_path = URI.parse(current_url).path
#  current_path.should == "/"
#  page.should have_content("Vous devez vous connecter pour accéder à cette page.")
#
#end