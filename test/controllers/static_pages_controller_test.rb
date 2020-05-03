require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get news" do
    get news_path
    assert_response :success
    assert_select "title", "News"
  end

end
