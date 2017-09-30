require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest

  test "create needs logged in user" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_path
  end
end
