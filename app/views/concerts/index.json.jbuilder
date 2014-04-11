json.array!(@concerts) do |concert|
  json.extract! concert, :id, :performer, :date
  json.url concert_url(concert, format: :json)
end
