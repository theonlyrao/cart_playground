class Pusher

  def self.client_id
    ENV["client_id"]
  end
  
  def self.client_secret
    ENV["client_secret"]
  end

end
