json.array!(@listen_events) do |listen_event|
  json.extract! listen_event, :id, :event_type, :recording_id
  json.url listen_event_url(listen_event, format: :json)
end
