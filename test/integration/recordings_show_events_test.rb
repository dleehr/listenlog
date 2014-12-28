require 'test_helper'

class RecordingsShowEventsTest < ActionDispatch::IntegrationTest
  fixtures :recordings, :listen_events
  test 'recordings show events' do
    recording = recordings(:ob_la)
    visit(recording_path(recording))
    assert page.has_link? 'Events', "Page should have 'Events' link"
    click_link 'Events'
    listen_event = recordings(:ob_la).listen_events.first
    assert page.has_link?('Show', :href => recording_listen_event_path(recording, listen_event)), 'Page should have a link to the listen event'
  end
  test 'recording shows last event' do
    visit(recording_path(recordings(:ob_la)))
    assert page.has_content? listen_events(:two).note
  end
end
