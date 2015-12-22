class OauthController < ApplicationController
  def kakao

    access_token_info = get_kakao_access_token(params[:code])
    puts access_token_info.inspect

    # get user info with access token
    url = 'https://kapi.kakao.com/v1/user/me'
    options = {
      Authoization: ENV['KAKAO_ADMIN_ID'],



    }
    render json: {}
  end

  def kakao_redirect
    redirect_to URI.escape("https://kauth.kakao.com/oauth/authorize?client_id=#{ENV['KAKAO_CLIENT_ID']}&redirect_uri=#{oauth_kakao_url}&response_type=code")
  end

  def get_kakao_access_token(code)
    options = {
      grant_type: 'authorization_code',
      client_id: ENV['KAKAO_CLIENT_ID'],
      redirect_to: oauth_kakao_url,
      code: code
    }
    url = 'https://kauth.kakao.com/oauth/token'
    response = HTTParty.post(url,
      :body => options
    )
    JSON.parse(response.body)
  end
end
