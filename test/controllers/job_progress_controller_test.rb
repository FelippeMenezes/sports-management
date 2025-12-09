require "test_helper"

class JobProgressControllerTest < ActionDispatch::IntegrationTest
  test "should get progress" do
    get job_progress_progress_url
    assert_response :success
  end

  test "should get status" do
    get job_progress_status_url
    assert_response :success
  end
end
