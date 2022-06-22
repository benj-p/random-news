require "test_helper"

class NewsletterSubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get newsletter_subscriptions_create_url
    assert_response :success
  end
end
