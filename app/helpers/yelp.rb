require 'oauth'

class Yelp
  consumer_key = ENV['YELP_CONSUMER_KEY']
  consumer_secret = ENV['YELP_CONSUMER_SECRET']
  token = ENV['YELP_TOKEN']
  token_secret = ENV['YELP_TOKEN_SECRET']

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://api.yelp.com"})
  @access_token = OAuth::AccessToken.new(consumer, token, token_secret)

  def self.search(lat, lon)
    path = "/v2/search?term=restaurants&ll=#{lat},#{lon}"
    results = MultiJson.load(@access_token.get(path).body)
    Hashie::Mash.new(results).businesses
  end
end