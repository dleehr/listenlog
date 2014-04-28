require 'test_helper'

class RecordingsShowEventsTest < ActionDispatch::IntegrationTest
  fixtures :recordings, :listen_events
  test 'recordings show events' do
    visit(recording_path(recordings(:ob_la)))
    assert page.has_link? 'Events', "Page should have 'Events' link"
    click_link 'Events'
    print page.html
    assert page.has_link? recording_path(recordings(:ob_la)), 'Unable to find link back to recording from events list'
  end
end
