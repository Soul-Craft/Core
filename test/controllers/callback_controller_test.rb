require 'test_helper'

class CallbackControllerTest < ActionDispatch::IntegrationTest
  test "should create a Salesforce account from a CREATED event" do
    message = {
      instanceId: 'sfdc-instance-1',
      events: [ { eventType: 'CREATED', elementKey: 'sfdc' } ],
      raw: {
        objectType: 'Account',
        Account: [ { Id: '001A', Name: 'Globex', Website: 'globex.example', CreatedDate: '2016-04-26T01:30:00Z' } ]
      }
    }

    assert_difference 'SalesforceAccount.count' do
      post '/callback/receive_data', params: { message: message }, as: :json
    end
    assert_response :success

    account = SalesforceAccount.find_by(account_id: '001A')
    assert_equal 'Globex', account.name
    assert_equal orgs(:acme), account.org
  end
end
