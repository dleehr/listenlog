json.array!(@recordings) do |recording|
  json.extract! recording, :id, :title, :concert_id, :active
end
