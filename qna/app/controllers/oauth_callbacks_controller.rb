class OauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :get_auth, :get_provider, :get_email, only: %i[github vkontakte]

  def github
    return render 'shared/email' unless @email
    oauth_authenticate(@auth, @provider, @email)
  end

  def vkontakte
    return render 'shared/email' unless @email
    oauth_authenticate(@auth, @provider, @email)
  end

  # get email from html
  def send_email
    session[:email] = params[:email]
    user = User.find_or_create(params[:email])
    confirmed_message(user)
  end

  private

  def get_auth
    @auth = request.env['omniauth.auth']
  end

  def get_email
    @email = @auth.info[:email] || User.find_by_auth(@auth)&.email || session[:email]
  end

  def get_provider
    @provider = @auth.provider
  end

  def confirmed_message(user)
    if user.confirmed?
      redirect_to questions_path, notice: 'You can sign in by provider'
    else
      redirect_to user_session_path, notice: "We send you email on #{user.email} for confirmation "
    end
  end
  
  def oauth_authenticate(auth, provider, email)
    @user = User.find_for_oauth(auth, email)

    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end
end