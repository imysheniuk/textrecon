class ShadowMessage < ActiveRecord::Base
  include Message
  belongs_to :user

  def self.send
    request_data = { :To => "[TO_NUMBER]", :Body => "Hello, from Shaun Koo!", :Token => ENV['TELAPI_TOKEN'] }
    r = HTTParty.post("https://heroku.telapi.com/send_sms", :body => request_data)
    puts r
  end

end
