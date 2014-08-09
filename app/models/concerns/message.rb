class Message

  attr_accessor :body, :ttl

  def initialize(options = {})
    options = {
      body: "",
      ttl: 15
    }.merge(options)

    @body = options[:body]
    @ttl = options[:ttl]
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
    return id
  end

  def Message.message_key_for_id(id = nil)
    "messages:#{id}"
  end

  def Message.message_read_key(id)
    "messages:#{id}:read_flag"
  end
end
