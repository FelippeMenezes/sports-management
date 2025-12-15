# config/initializers/active_job.rb
if Rails.env.production?
  # Configura o Active Job para usar a URL do Redis fornecida pela variável de ambiente.
  # Isso garante que tanto o enfileiramento de jobs (pelo app Rails) quanto o processamento
  # (pelo worker Sidekiq) usem a mesma instância do Redis (ex: Upstash).
  Rails.application.config.active_job.queue_adapter_options = { url: ENV.fetch('REDIS_URL') }
end
