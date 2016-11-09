class GithubService

   def authenticate!(client_id, client_secret, code)
     response = Faraday.post( "https://github.com/login/oauth/access_token") do |req|
       req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params[:code] = code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, 
    {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

   end

end