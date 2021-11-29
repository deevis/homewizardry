require "application_system_test_case"

class DoorMessagesTest < ApplicationSystemTestCase
  setup do
    @door_message = door_messages(:one)
  end

  test "visiting the index" do
    visit door_messages_url
    assert_selector "h1", text: "Door Messages"
  end

  test "creating a Door message" do
    visit door_messages_url
    click_on "New Door Message"

    fill_in "Message", with: @door_message.message
    click_on "Create Door message"

    assert_text "Door message was successfully created"
    click_on "Back"
  end

  test "updating a Door message" do
    visit door_messages_url
    click_on "Edit", match: :first

    fill_in "Message", with: @door_message.message
    click_on "Update Door message"

    assert_text "Door message was successfully updated"
    click_on "Back"
  end

  test "destroying a Door message" do
    visit door_messages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Door message was successfully destroyed"
  end
end
