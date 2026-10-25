require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get the login page" do
    get root_path
    assert_response :success
    assert_select 'form[action=?]', '/welcome/check_user'
  end

  test "should reject a wrong password" do
    post welcome_check_user_path, params: { email: 'ada@example.com', password: 'not-the-password' }
    assert_redirected_to controller: 'welcome', action: 'index', view: 'login'
    assert_equal 'Incorrect Password', flash[:failure]
  end

  test "should sign up a new org with its admin and log them in" do
    assert_difference [ 'Org.count', 'User.count' ] do
      post welcome_signup_path, params: { org: 'Initech', firstname: 'Peter', lastname: 'Gibbons',
                                          email: 'peter@example.com', password1: 'tps-reports-1' }
    end
    assert_redirected_to controller: 'welcome', action: 'setup'

    user = User.find_by(email: 'peter@example.com')
    assert_equal 'Initech', user.org.name
    assert user.is_admin
    assert user.valid_password?('tps-reports-1')

    get core_run_path
    assert_response :success
  end
end
