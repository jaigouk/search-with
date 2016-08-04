db = {
  'development' => 0,
  'test' => 1,
  'production' => 10
}[Rails.env]
REDIS_URL = ENV['REDISCLOUD_URL'] || "redis://localhost:6379/#{db}"

$redis = Redis.new(url: ENV["REDIS_URL"])
