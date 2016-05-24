require 'net/http'

class GithubAuth

  def self.register(code)
    uri = URI.parse("https://github.com/login/oauth/access_token")
    args = { client_id: Pusher.client_id,
             client_secret: Pusher.client_secret,
             code: code
           }
    res = Net::HTTP.post_form(uri, args)
    uri = URI("https://api.github.com/user?#{res.body}")
    user_data = JSON.parse(Net::HTTP.get(uri))
    {user_data: user_data, token: res.body}
  end

end
