Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  # Sidekiq-Status server-side middleware
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30 * 60 # 30 minutes in seconds
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  # Sidekiq-Status client-side middleware
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end
