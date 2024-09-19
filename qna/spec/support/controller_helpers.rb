module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  def mock_oauth(provider, email = nil)
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(
      provider: provider.to_s,
      uid: '123',
      info: { email: email }
    )
  end
end