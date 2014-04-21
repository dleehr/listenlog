require 'test_helper'

class ConcertTest < ActiveSupport::TestCase
  test 'validates artist' do
    concert = Concert.new()
    assert_not concert.save, 'should not save without artist'
  end
end
