json.extract! @concert, :id, :performer, :date, :location, :created_at, :updated_at
json.recordings do
  json.array! @concert.recordings do |recording|
    json.extract! recording, :id, :title
    json.url recording_url(recording, format: :json)
  end
end
