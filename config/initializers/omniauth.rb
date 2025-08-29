previous_before_request_phase = OmniAuth.config.before_request_phase
OmniAuth.config.before_request_phase = -> (env) do
  # This is just in case there was something else configured before
  previous_before_request_phase.call(env) if previous_before_request_phase

  # Make sure the session cookie's SameSite option is set to `None` so that when
  # Apple does the callback phase with a POST request, we'll get the session cookie.
  #
  # Ideally, I'd check here if this request is going to Apple and not some other
  # Identity Provider where doing this is not necessary. But I'm not sure how to
  # check for that in here.
  env['rack.session.options']['same_site'] = 'None'
  env['rack.session.options']['secure'] = true
end

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]

  # 또는 Redirect Path를 설정하고 싶다면(or if you want to customize your Redirect Path)
  #provider :kakao, ENV['KAKAO_KEY'], {:redirect_path => '/users/auth/kakao/callback'}
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end