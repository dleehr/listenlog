require 'test_helper'

class AngularBootstrapControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    sign_in(User.first)
  end
  teardown do
    sign_out(User.first)
  end
  test "should get index" do
    get :index
    assert_response :success
  end

end
