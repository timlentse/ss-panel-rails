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

  def self.set_key_with_expire(key, value, seconds=10800)
    @redis.set(key, value)
    @redis.expire(key, seconds )
  end

end
