class MessagesController < ApplicationController

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
 
    if @id = @message.save
      request_data = {:from => ENV['FROM_NUMBER'], :To => params[:message][:to], :Body => "Hello, #{current_user.name} sent you a private message in #{message_url(@id)}", :Token => ENV['TELAPI_TOKEN'] }
      r = HTTParty.post("https://heroku.telapi.com/send_sms", :body => request_data)
       flash[:notice] = "Message was sent."
       redirect_to new_message_url
     else
       flash[:error] = "There was an error sending the message. Please try again."
       render :new
     end
  end

end
