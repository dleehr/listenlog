json.array!(@concerts) do |concert|
  json.extract! concert, :id, :artist_id, :date, :location
  json.url concert_url(concert, format: :json)
end
