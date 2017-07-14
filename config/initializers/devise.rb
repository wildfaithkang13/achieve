Devise.setup do |config|
  config.secret_key = '0acb45e610e875c9d4b693a7ef1e31d58de7bc55d5dad0d58c7d13808d99990a83eb9f8fbd31250c9f5033f5c8716cd3e6ab0cc8803d3f31f8a87104473b937d'
  config.mailer_sender = 'noreply@yourdomain';
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  if Rails.env.production?
    config.omniauth :facebook, ENV["FACEBOOK_ID_PRODUCTION"], ENV["FACEBOOK_SECRET_PRODUCTION"], scope: 'email', display: 'popup', info_fields: 'name, email'
    config.omniauth :twitter, ENV["TWITTER_ID_PRODUCTION"], ENV["TWITTER_SECRET_PRODUCTION"], scope: 'email', display: 'popup', info_fields: 'name, email'
  else
    config.omniauth :facebook, ENV["FACEBOOK_ID_DEVELOPMENT"], ENV["FACEBOOK_SECRET_DEVELOPMENT"], scope: 'email', display: 'popup', info_fields: 'name, email'
    config.omniauth :twitter, ENV["TWITTER_ID_DEVELOPMENT"], ENV["TWITTER_SECRET_DEVELOPMENT"], scope: 'email', display: 'popup', info_fields: 'name, email'
  end

end
