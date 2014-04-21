class Concert < ActiveRecord::Base
  has_many :recordings, :dependent => :destroy
  has_many :listen_events, :through => :recordings
  belongs_to :artist

  def performer
    artist.name
  end

  def title
    "#{performer} - #{date}"
  end
end
