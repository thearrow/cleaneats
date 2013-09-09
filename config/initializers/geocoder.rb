Geocoder.configure(

    # geocoding service (see below for supported options):
    :lookup => :mapquest,

    # to use an API key:
    :api_key => ENV['MAPQUEST_API_KEY'],

    #:http_headers => { "Referer" => "http://cleaneats.herokuapp.com" }

    # geocoding service request timeout, in seconds (default 3):
    #:timeout => 5,

    # set default units to kilometers:
    #:units => :km,

    # caching (see below for details):
    #:cache => Redis.new,
    #:cache_prefix => "..."
)