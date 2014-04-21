require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  test 'validates name' do
    artist = Artist.new()
    assert_not artist.save, 'should not save without name'
  end
end
