require 'test_helper'

class ConcertTest < ActiveSupport::TestCase
  test 'validates performer' do
    concert = Concert.new()
    assert_not concert.save, 'should not save without performer'
  end
end
