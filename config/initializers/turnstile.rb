Cloudflare::Turnstile.configure do |config|
  config.site_key   = ENV.fetch("TURNSTILE_SITE_KEY")
  config.secret_key = ENV.fetch("TURNSTILE_SECRET_KEY")
end