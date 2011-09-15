module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /the register page/
      new_user_path

    when /the register page/
      new_user_session

    when /the edit user page with id (.*)/
      user = User.find($1)
      edit_user_path user

    when /^the user_activates new page with username (.*)$/
      user = User.find_by_username($1)
      url_for(:controller => :user_activates, :action => :new, :id => user.perishable_token)

    when /^the (.*) (.*) page with id ([0-9]*)$/
      url_for(:controller => $1, :action => $2, :id => $3)

    when /^the (.*) (.*) page with id ([0-9]*) with method (.*)$/
      url_for(:controller => $1, :action => $2, :id => $3)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can'at find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
