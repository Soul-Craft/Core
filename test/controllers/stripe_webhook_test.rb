require 'test_helper'

class StripeWebhookTest < ActionDispatch::IntegrationTest
  test "should refuse an unsigned webhook" do
    post '/stripe-Webhooks', params: { type: 'charge.succeeded' }, as: :json
    assert_response :bad_request
  end
end
