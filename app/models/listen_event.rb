class ListenEvent < ActiveRecord::Base
  START = 1
  PAUSE = 2
  RESUME = 3
  FINISH = 4
  belongs_to :recording
  scope :by_recording, lambda{|r| where(:recording_id=> r)}
  scope :start_events, lambda{ where :event_type => START }
  scope :pause_events, lambda{ where :event_type => PAUSE }
  scope :resume_events, lambda{ where :event_type => RESUME }
  scope :finish_events, lambda{ where :event_type => FINISH }
  scope :active_events, lambda{ where :event_type => [START,PAUSE, RESUME] }
  scope :by_age, lambda{ order :created_at}
  default_scope { order('created_at ASC') }

  def is_start?
    event_type == START
  end

  def is_pause?
    event_type == PAUSE
  end

  def is_finish?
    event_type == FINISH
  end

  def is_resume?
    event_type == RESUME
  end

  def self.start_event(note=nil)
    new(:event_type => START, :note => note)
  end

  def self.pause_event(note=nil)
    new(:event_type => PAUSE, :note => note)
  end

  def self.resume_event(note=nil)
    new(:event_type => RESUME, :note => note)
  end

  def self.finish_event(note=nil)
    new(:event_type => FINISH, :note => note)
  end

  def self.last
    self.by_age.last
  end

end
