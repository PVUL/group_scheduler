class OauthController < ApplicationController
  def kakao
    access_token_info = get_kakao_access_token(params[:code])
    puts access_token_info.inspect
    user_info = get_kakao_user_id(access_token_info['access_token'])
    puts user_info.inspect
    current_user[:uid] = user_info["id"]
    current_user[:nickname] = user_info["properties"]["nickname"]
    current_user[:photo_url] = user_info["properties"]["thumbnail_image"]
    current_user.save
    redirect_to user_path(current_user)
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

  def get_kakao_user_id(access_token)
    headers = { "Authorization" => "Bearer #{access_token}" }
    url = 'https://kapi.kakao.com/v1/user/me'
    response = HTTParty.get(url, :headers => headers )
    JSON.parse(response.body)
  end
end
