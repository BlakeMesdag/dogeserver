uri = URI.parse(Settings::KEYS["REDISCLOUD_URL"])
Redis.current = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)