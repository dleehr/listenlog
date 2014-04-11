class Recording < ActiveRecord::Base
  belongs_to :concert
  has_many :listen_events, :dependent => :destroy

  def start_listening
    # if the last event is a start_listening fail
    if listen_events.empty? || listen_events.last.is_finish?
      listen_event = ListenEvent.start_event
      listen_events << listen_event
      listen_event
    else
      nil
    end

  end

  def finish_listening
    if listen_events.empty? || listen_events.last.is_start?
      listen_event = ListenEvent.start_event
      listen_events << listen_event
      listen_event
    else
      nil
    end
  end

end
