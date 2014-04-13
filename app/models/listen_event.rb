class ListenEvent < ActiveRecord::Base
  START = 1
  FINISH = 2
  belongs_to :recording
  scope :by_recording, lambda{|r| where(:recording_id=> r)}
  scope :start_events, lambda{ where :event_type => START }
  scope :finish_events, lambda{ where :event_type => FINISH }


  def is_start?
    event_type == START
  end

  def is_finish?
    event_type == FINISH
  end

  def self.start_event
    new(:event_type => START)
  end

  def self.finish_event
    new(:event_type => FINISH)
  end

end
