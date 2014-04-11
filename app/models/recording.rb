class Recording < ActiveRecord::Base
  belongs_to :concert
  has_many :listen_events, :dependent => :destroy

  def start_listening
    # if the last event is a start_listening fail
    if listen_events.empty? || listen_events.last.is_finish?
      listen_events << ListenEvent.start_event
      true
    else
      false
    end

  end

  def finish_listening
    if listen_events.empty? || listen_events.last.is_start?
      listen_events << ListenEvent.finish_event
      true
    else
      false
    end
  end

end
