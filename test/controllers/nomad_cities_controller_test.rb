require 'test_helper'

class NomadCitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nomad_cities_index_url
    assert_response :success
  end

end
