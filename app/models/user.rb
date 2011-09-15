class User < ActiveRecord::Base
  acts_as_authentic

  validate :password, :presence => true

  acts_as_authentic do |config|
    config.ignore_blank_passwords = false
    config.maintain_sessions = false
  end
  
  def to_s
    username
  end
end
