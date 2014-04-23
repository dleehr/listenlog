json.array!(@concerts) do |concert|
  json.extract! concert, :id, :performer, :date, :location
  json.url concert_url(concert, format: :json)
end
