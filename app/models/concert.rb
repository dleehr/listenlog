class Concert < ActiveRecord::Base
  has_many :recordings, :dependent => :destroy
  has_many :listen_events, :through => :recordings
end
