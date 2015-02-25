json.array!(@listen_events) do |listen_event|
  json.extract! listen_event, :id, :event_type, :recording_id, :note
  json.url recording_listen_event_url(listen_event.recording, listen_event, format: :json)
end
