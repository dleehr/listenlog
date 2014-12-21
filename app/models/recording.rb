class Recording < ActiveRecord::Base
  belongs_to :concert
  has_many :listen_events, -> { order('created_at ASC') }, :dependent => :destroy
  scope :by_concert, lambda{|c| where(:concert_id => c)}
  scope :by_listening, lambda{|l| where(listening: l)}
  scope :listening, lambda{ by_listening(true)}
  scope :not_listening, lambda{ by_listening(false)}

  validates :title, :presence => true

  def start_listening(note=nil)
    unless listening?
      self.listening = true
      save
      listen_event = ListenEvent.start_event(note)
      listen_events << listen_event
      listen_event
    else
      errors.add(:listen_events, "Listening in progress, stop first")
      nil
    end

  end

  def finish_listening(note=nil)
    if listening?
      self.listening = false
      save
      listen_event = ListenEvent.stop_event(note)
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

  def last_event
    listen_events.last
  end

end
