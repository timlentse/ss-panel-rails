require 'redis'

class MyRedis 

  def initialize
    @redis = Redis.new
  end

  def get(key)
    @redis.get(key)
  end

  def set(key, value)
    @redis.set(key, value)
  end

  def set_key_with_expire(key, value, seconds=10800)
    @redis.set(key, value)
    @redis.expire(key, seconds )
  end

end
