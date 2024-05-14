require "test_helper"

class DogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url, as: :html
    assert_response :success
    assert_template "index"
  end

  test "should update image via Turbo Stream on submit" do
    response_body = { message: "https://example.com/image.jpg" }.to_json

    stub_request(:get, "https://dog.ceo/api/breeds/image/random").
      to_return(body: response_body)

    post submit_url, as: :turbo_stream

    assert_response :success

    assert_requested :get, "https://dog.ceo/api/breeds/image/random"

    assert_select "turbo-stream[action='update'][target='image']" do
      assert_select "img[src='https://example.com/image.jpg']"
    end
  end
end
