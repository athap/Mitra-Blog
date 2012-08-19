Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings['twitter_key'], Settings['twitter_secret']
end