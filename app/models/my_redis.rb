require 'redis'

class MyRedis 

  def self.current
    @redis = Redis.current
    self
  end

  def self.get(key)
    @redis.get(key)
  end

  def self.set(key, value)
    @redis.set(key, value)
  end

  def self.delete_session_token(key)
    @redis.del "session_#{key}"
  end

  def self.set_session_token(key,value,seconds=nil)
    key = "session_#{key}"
    @redis.set(key,value)
    @redis.expire(key,seconds) if seconds
  end

  def self.get_session_token(key)
    @redis.get "session_#{key}"
  end

  def self.set_verify_token(key,value,seconds=nil)
    key = "verify_#{key}"
    @redis.set(key,value)
    @redis.expire(key,seconds) if seconds
  end

  def self.get_verify_token(key)
    @redis.get "verify_#{key}"
  end

end
