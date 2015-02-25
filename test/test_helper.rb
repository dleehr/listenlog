require 'coveralls'
Coveralls.wear!('rails')
ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # devise helpers sign_in doesn't work with integration tests
  def sign_in_as(user, password)
    User.where(:email => user).delete_all
    user = User.create(:password => password, :password_confirmation => password, :email => user)
    user.save!
    visit '/'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => password
    click_link_or_button('Log in')
    user
 end
 def sign_out(email)
  # This space intentionally left blank. Should log out but we don't have those links!
 end
end