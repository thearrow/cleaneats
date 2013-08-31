json.array!(@places) do |place|
  json.extract! place, :id_citygrid, :id_yelp, :id_google
  json.url place_url(place, format: :json)
end
