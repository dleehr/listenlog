class ListenEvent < ActiveRecord::Base
  START = 1
  STOP = 2
  FINISH = 3
  belongs_to :recording
  scope :by_recording, lambda{|r| where(:recording_id=> r)}
  scope :start_events, lambda{ where :event_type => START }
  scope :stop_events, lambda{ where :event_type => STOP }
  scope :finish_events, lambda{ where :event_type => FINISH }
  scope :active_events, lambda{ where :event_type => [START,STOP] }
  scope :by_age, lambda{ order :created_at}
  order :created_at

  def is_start?
    event_type == START
  end

  def is_stop?
    event_type == STOP
  end

  def self.start_event(note=nil)
    new(:event_type => START, :note => note)
  end

  def self.stop_event(note=nil)
    new(:event_type => STOP, :note => note)
  end

  def self.last
    self.by_age.last
  end

end
