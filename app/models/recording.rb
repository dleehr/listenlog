class Recording < ActiveRecord::Base
  belongs_to :concert
  has_many :listen_events, :dependent => :destroy
  scope :by_concert, lambda{|c| where(:concert_id => c)}

  def start_listening
    # if the last event is a start_listening fail
    if listen_events.empty? || listen_events.last.is_finish?
      listen_event = ListenEvent.start_event
      listen_events << listen_event
      listen_event
    else
      errors.add(:listen_events, "Listening in progress, stop first")
      nil
    end

  end

  def finish_listening
    if listen_events.empty? || listen_events.last.is_start?
      listen_event = ListenEvent.finish_event
      listen_events << listen_event
      listen_event
    else
      errors.add(:listen_events, "No listen in progress, cannot stop")
      nil
    end
  end

  def listening?
    return false if listen_events.empty?
    listen_events.last.is_start?
  end

end
