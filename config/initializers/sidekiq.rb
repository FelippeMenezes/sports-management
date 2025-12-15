Sidekiq.configure_server do |config|
  redis_url = ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')
  if Rails.env.production?
    # Upstash requires TLS, so we ensure the URL scheme is 'rediss://'
    redis_url.sub!('redis://', 'rediss://')
  end
  config.redis = { url: redis_url }

  # Sidekiq-Status server-side middleware
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30 * 60 # 30 minutes in seconds
  end
end

Sidekiq.configure_client do |config|
  redis_url = ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')
  if Rails.env.production?
    # Upstash requires TLS, so we ensure the URL scheme is 'rediss://'
    redis_url.sub!('redis://', 'rediss://')
  end
  config.redis = { url: redis_url }

  # Sidekiq-Status client-side middleware
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end
