config = YAML.load_file(Rails.root.join("config",'application.yml'))

var_string = ""

config.each_pair do |key, val|
  var_string += " #{key}=#{val}"
end

puts "heroku config:set#{var_string}"