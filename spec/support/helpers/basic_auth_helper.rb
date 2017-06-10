module BasicAuthHelper
  def http_authenticate
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(Rails.application.secrets.whereiam, Rails.application.secrets.whereiam)
  end
end
