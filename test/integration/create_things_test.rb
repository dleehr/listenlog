require 'test_helper'

class CreateThingsTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as('testuser@localhost.com', 'monkey1234')
  end
  teardown do
    sign_out('testuser@localhost.com')
  end
  test 'Create an artist' do
    visit(artists_path)
    click_link('New Artist')
    assert current_path == new_artist_path
    fill_in('Name', :with => 'My New Artist')
    click_on('Create Artist')
    assert page.has_content? 'successfully'
    assert page.has_content? 'My New Artist'
  end

  test 'Create a concert' do
    visit(concerts_path)
    click_link('New Concert')
    assert current_path == new_concert_path
    select artists(:pj).name, :from => 'Artist'
    select '1999', :from => 'concert_date_1i'
    select 'December', :from => 'concert_date_2i'
    select '31', :from => 'concert_date_3i'
    click_on 'Create Concert'
    assert page.has_content? 'successfully'
    assert page.has_content? '1999-12-31'
  end

end
