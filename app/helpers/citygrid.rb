class Citygrid
  include HTTParty
  format :json
  base_uri 'api.citygridmedia.com/content/places/v2'

  def self.search(lat, lon, radius)
    response = get('/search/latlon', :query => {
        :type => 'restaurant',
        :format => 'json',
        :publisher => ENV['CITYGRID_API_KEY'],
        :lat => lat,
        :lon => lon,
        :radius => radius,
    })
    Hashie::Mash.new(response['results'])
  end

  def self.search_text(query)
    response = get('/search/where', :query => {
        :type => 'restaurant',
        :format => 'json',
        :publisher => ENV['CITYGRID_API_KEY'],
        :where => query
    })
    Hashie::Mash.new(response['results'])
  end
end