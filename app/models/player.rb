class Player < ActiveRecord::Base
  attr_reader :username
  def initialize(attr = {})
    @username = attr[:username]
    @password = attr[:password]
  end
end
