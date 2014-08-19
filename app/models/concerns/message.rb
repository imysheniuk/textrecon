class Message

  include ActiveModel::Model

  attr_accessor :body, :ttl, :to

  def initialize(options = {})
    options = {
      "body" => "",
      "ttl" => 15
    }.merge(options)

    @body = options["body"]
    @ttl = options["ttl"]
  end

  def Message.recent_messages
    REDIS.lrange Message.global_key,0,4
  end

  def Message.find(id)
    message = REDIS.hgetall Message.message_key_for_id(id)
    
    body = message["body"]
    ttl = message["ttl"].to_i
    unless REDIS.exists(Message.message_read_key(id))
      REDIS.set Message.message_read_key(id), "yes"
      REDIS.expire Message.message_key_for_id(id), ttl
      REDIS.expire Message.message_read_key(id), ttl
    end
    return body
  end

  def save
    id = SecureRandom.hex(10)
    REDIS.hmset Message.message_key_for_id(id), "body", self.body, "ttl", ttl
    REDIS.lpush Message.global_key, self.body
    REDIS.ltrim Message.global_key, 0, 4
    puts REDIS.hgetall(Message.message_key_for_id(id)).inspect
    puts Message.message_key_for_id(id)
    return id
  end

  def Message.global_key
    "recent_messages"
  end

  def Message.message_key_for_id(id = nil)
    "messages:#{id}"
  end

  def Message.message_read_key(id)
    "messages:#{id}:read_flag"
  end
end
