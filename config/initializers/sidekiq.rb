# Determine the correct Redis URL based on the environment.
redis_url = ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')
if Rails.env.production? && redis_url.start_with?('redis://')
  # Upstash requires TLS, so we ensure the URL scheme is 'rediss://'.
  # Use non-destructive `sub` to avoid FrozenError on ENV strings.
  redis_url = redis_url.sub('redis://', 'rediss://')
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }

  # Sidekiq-Status server-side middleware
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30 * 60 # 30 minutes in seconds
  end
end
