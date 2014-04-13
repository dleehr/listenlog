class Recording < ActiveRecord::Base
  belongs_to :concert
  has_many :listen_events, :dependent => :destroy
  scope :by_concert, lambda{|c| where(:concert_id => c)}
  scope :listening, lambda{ where(listening: true)}
  scope :not_listening, lambda{ where(listening:false)}

  validates :title, :presence => true

  def start_listening
    # if the last event is a start_listening fail
    unless listening?
      self.listening = true
      save
      listen_event = ListenEvent.start_event
      listen_events << listen_event
      listen_event
    else
      errors.add(:listen_events, "Listening in progress, stop first")
      nil
    end

  end

  def finish_listening
    if listening?
      self.listening = false
      save
      listen_event = ListenEvent.finish_event
      listen_events << listen_event
      listen_event
    else
      errors.add(:listen_events, "No listen in progress, cannot stop")
      nil
    end
  end

  def listening?
    listening
  end

end
