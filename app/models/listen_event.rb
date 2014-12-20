class ListenEvent < ActiveRecord::Base
  START = 1
  FINISH = 2
  belongs_to :recording
  scope :by_recording, lambda{|r| where(:recording_id=> r)}
  scope :start_events, lambda{ where :event_type => START }
  scope :finish_events, lambda{ where :event_type => FINISH }
  scope :by_age, lambda{ order :created_at}
  order :created_at

  def is_start?
    event_type == START
  end

  def is_finish?
    event_type == FINISH
  end

  def self.start_event(note=nil)
    new(:event_type => START, :note => note)
  end

  def self.finish_event(note=nil)
    new(:event_type => FINISH, :note => note)
  end

  def self.last
    self.by_age.last
  end

end
