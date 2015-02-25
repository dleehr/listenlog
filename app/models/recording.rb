class Recording < ActiveRecord::Base
  belongs_to :concert
  has_many :listen_events, -> { order('created_at ASC') }, :dependent => :destroy
  scope :by_concert, lambda{|c| where(:concert_id => c)}
  scope :by_listening, lambda{|l| where(listening: l)}
  scope :listening, lambda{ by_listening(true)}
  scope :by_active, lambda{|a| where(active: a)}
  scope :active, lambda{ by_active(true)}
  scope :not_listening, lambda{ by_listening(false)}
  default_scope { order('created_at DESC') }

  validates :title, :presence => true

  def start_listening(note=nil)
    self.active = true
    create_event(:start_event, false, note)
  end

  def pause_listening(note=nil)
    create_event(:pause_event, true, note)
  end

  def resume_listening(note=nil)
    create_event(:resume_event, false, note)
  end

  def finish_listening(note=nil)
    self.active = false
    create_event(:finish_event, true, note)
  end

  def listening?
    listening
  end

  def last_event
    listen_events.last
  end

  private

  def create_event(type, expected_listening, note=nil)
    if listening? == expected_listening
      self.listening = !expected_listening
      save
      listen_event = ListenEvent.send(type, note)
      listen_events << listen_event
      listen_event
    else
      errors.add(:listen_events, "Failed to create event,listening state should be #{expected_listening}.")
      nil
    end

  end

end
