class Services::FindForOauth
  attr_reader :auth, :email

  def initialize(auth, email)
    @auth = auth
    @email = email
  end

  def call
    user = User.find_by(email: email)

    unless user
      user = User.find_by_auth(auth)
      user ||= User.create_with_rand_password!(email)
    end
    user.create_authorization(auth)
    user
  end
end