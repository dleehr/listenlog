class ListenEvent < ActiveRecord::Base
  START = 1
  FINISH = 2
  PAUSE = 3
  RESUME = 4

  belongs_to :recording
  scope :by_recording, lambda{|r| where(:recording_id=> r)}
  scope :start_events, lambda{ where :event_type => START }
  scope :finish_events, lambda{ where :event_type => FINISH }
  scope :pause_events, lambda{ where :event_type => PAUSE }
  scope :resume_events, lambda{ where :event_type => RESUME }

  order :created_at

  def is_start?
    event_type == START
  end

  def is_finish?
    event_type == FINISH
  end

  def is_pause?
    event_type == PAUSE
  end

  def is_resume?
    event_type == RESUME
  end

  def self.start_event
    new(:event_type => START)
  end

  def self.finish_event
    new(:event_type => FINISH)
  end

  def self.pause_event
    new(:event_type => PAUSE)
  end

  def self.resume_event
    new(:event_type => RESUME)
  end

end
