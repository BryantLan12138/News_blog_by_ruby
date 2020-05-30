require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
 
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar",
                                         phone: "123456" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {
                                  name: "Helloa",
                                  email: "Helloa@Helloa.com",
                                  password: "Helloa",
                                  phone: "123456123456",
                                  password_confirmation: "Helloa"
                                }}
                          end
      follow_redirect!
      assert_template 'users/show'
      assert is_logged_in?
  end 

end
