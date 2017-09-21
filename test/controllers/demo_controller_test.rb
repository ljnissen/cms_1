require 'test_helper'

class DemoControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_select "title", "Index | Content Management System (CMS)"
  end

  test "should get about" do
    get :about
    assert_select "title", "About | Content Management System (CMS)"
  end

end
