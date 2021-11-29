require "test_helper"

class DoorMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @door_message = door_messages(:one)
  end

  test "should get index" do
    get door_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_door_message_url
    assert_response :success
  end

  test "should create door_message" do
    assert_difference('DoorMessage.count') do
      post door_messages_url, params: { door_message: { message: @door_message.message } }
    end

    assert_redirected_to door_message_url(DoorMessage.last)
  end

  test "should show door_message" do
    get door_message_url(@door_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_door_message_url(@door_message)
    assert_response :success
  end

  test "should update door_message" do
    patch door_message_url(@door_message), params: { door_message: { message: @door_message.message } }
    assert_redirected_to door_message_url(@door_message)
  end

  test "should destroy door_message" do
    assert_difference('DoorMessage.count', -1) do
      delete door_message_url(@door_message)
    end

    assert_redirected_to door_messages_url
  end
end
