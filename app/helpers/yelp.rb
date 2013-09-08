require 'oauth'

class Yelp
  consumer_key = ENV['YELP_CONSUMER_KEY']
  consumer_secret = ENV['YELP_CONSUMER_SECRET']
  token = ENV['YELP_TOKEN']
  token_secret = ENV['YELP_TOKEN_SECRET']

  consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://api.yelp.com"})
  @access_token = OAuth::AccessToken.new(consumer, token, token_secret)

  def self.search(lat, lon)
    path = "/v2/search?&ll=#{lat},#{lon}&term=restaurants"
    results = MultiJson.load(@access_token.get(path).body)
    Hashie::Mash.new(results).businesses
  end

  def self.search_text(where)
    path = "/v2/search?&location=#{CGI::escape(where)}&term=restaurants"
    results = MultiJson.load(@access_token.get(path).body)
    Hashie::Mash.new(results).businesses
  end

  def self.search_name(lat, lon, name)
    path = "/v2/search?&ll=#{lat},#{lon}&term=#{CGI::escape(name)}&limit=1"
    results = MultiJson.load(@access_token.get(path).body)
    Hashie::Mash.new(results).businesses.first
  end

  def self.lookup(id)
    path = "/v2/business/#{id}"
    results = MultiJson.load(@access_token.get(path).body)
    Hashie::Mash.new(results)
  end
end