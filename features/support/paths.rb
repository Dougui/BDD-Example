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

    when /the login page/
      '/login'

    when /^(.*)'s edit page$/i
      user = User.find_by_username($1)
      url_for(:controller => :users, :action => :edit, :id => user.id, :only_path => true)

    when /^(.*)'s reset password page$/i
      user = User.find_by_username($1)
      url_for(:controller => :user_reset_passwords, :action => :edit, :id => user.perishable_token, :only_path => true)

    when /^(.*)'s activate page$/i
      user = User.find_by_username($1)
      url_for(:controller => :user_activates, :action => :new, :id => user.perishable_token, :only_path => true)


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
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
