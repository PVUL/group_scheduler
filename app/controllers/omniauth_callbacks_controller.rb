class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    request.env["omniauth.auth"].to_yaml
    # if user.persisted?
    #   sign_in_and_redirect user, notice: "Signed in!"
    # else
    #   redirect_to new_user_registration_url
    # end
  end
  alias_method :facebook, :all
end
