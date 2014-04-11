json.array!(@recordings) do |recording|
  json.extract! recording, :id, :title, :concert_id
  json.url recording_url(recording, format: :json)
end
