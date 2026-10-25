require 'test_helper'

class CoreControllerTest < ActionDispatch::IntegrationTest
  test "should send visitors who are not logged in to the login page" do
    get core_run_path
    assert_redirected_to controller: 'welcome', action: 'index'
  end

  test "should get run once logged in" do
    QuickbooksInvoice.create!(org: orgs(:acme), balance: 25, total_amt: 100, date_created: Date.today)
    QuickbooksInvoice.create!(org: orgs(:acme), balance: 0, total_amt: 50, date_created: Date.today)

    post welcome_check_user_path, params: { email: 'ada@example.com', password: 'password123' }
    assert_redirected_to controller: 'core', action: 'run'

    get core_run_path
    assert_response :success
    assert_select '#customer_count h1', '0'
    assert_select '#share h1', '1'
  end
end
