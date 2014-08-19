class WelcomeController < ApplicationController
  def index
    @messages = Message.recent_messages
  end

  def about
  end
end
