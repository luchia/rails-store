require 'test_helper'

class StoreControllerTest < ActionController::TestCase
	test "should get index" do
		get :index
		assert_response :success
		assert_select 'section.top-bar-section ul.right li', minimum: 1
	end
end
