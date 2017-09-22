require 'test_helper'

class DemoControllerTest < ActionController::TestCase
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Content Management System (CMS)"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Content Management System (CMS)"
  end

end
