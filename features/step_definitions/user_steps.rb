#encoding=utf-8
module UserHelpers
  def log_a_user(user)
    visit login_path
    fill_in 'user_session_username', :with => user.username
    fill_in 'user_session_password', :with => user.password
    click_button "Se connecter"
  end

  def create_a_user_from_fields(fields)
    user = Factory.build(:user)
    fields.rows_hash.each do |field, value|
      user.attributes = { field => value }
    end
    user.save
    user
  end
end
World(UserHelpers)

Given /^I have no users$/ do
  User.destroy_all
end

Given /^I have a user with ([^"]*) "([^"]*)"$/ do |field, value|
  Factory.create(:user, field.to_sym => value)
end

Given /^I am a logged user$/ do
  user = Factory.create(:user, :active => true)
  log_a_user(user)
end

Given /^I am a logged user with ([^"]*) "([^"]*)"$/ do  |field, value|
  user = Factory.create(:user, :active => true, field.to_sym => value)
  log_a_user(user)
end

Given /^I am a logged user with this following:$/ do |fields|
  user = create_a_user_from_fields(fields)
  log_a_user(user)
end


When /^I create a user$/ do
  When "I fill in \"user_username\" with \"dougui\""
  When "I fill in \"user_email\" with \"guirec.corbel@gmail.com\""
  When "I fill in \"user_password\" with \"test1234\""
  When "I fill in \"user_password_confirmation\" with \"test1234\""
  When "I press \"S'inscrire\""
end

When /^(?:|I )have a user with this following:$/ do |fields|
  create_a_user_from_fields(fields)
end


Then /^I should have (\d+|no) users?$/ do |count|
  count = 0 if count == "no"
  User.all.count.should == count.to_i
end

Then /^I should see a link for ([^"]*) in the email body$/ do |page_name|
  open_email(current_email_address)
  current_email.default_part_body.to_s.should include(path_to(page_name))
end

Then /^I should have (\d+|no|a) users? with this following:$/ do |count, fields|
  count = 0 if count == "no"
  count = 1 if count == "a"

  users = User

  fields.rows_hash.each do |field, value|

    case User.columns_hash[field].sql_type
    when "boolean"
      if value.downcase == "true"
        users = users.where(field.to_sym => true)
      else
        users = users.where(field.to_sym => false)
      end
    else
      users = users.where(field.to_sym => value)
    end
  end
  users.count.should == count.to_i
end