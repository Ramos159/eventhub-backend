require 'test_helper'

class VenueEventControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get venue_event_index_url
    assert_response :success
  end

  test "should get show" do
    get venue_event_show_url
    assert_response :success
  end

end
