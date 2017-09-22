require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
  	get root_path
  	assert_template 'demo/index'
  	assert_select "a[href = ?]", root_path, count: 2
  	assert_select "a[href = ?]", about_path
  end
end
