require "test_helper"

class UserCanRemoveItemFromCartTest < ActionDispatch::IntegrationTest
  def user_can_remove_item_from_cart_test
    ApplicationController.stub_any_instance(:current_cart, ["1TK"]) do
      visit cart_path
      assert page.has_content?("$14.99")
      within ".1tk" do
        click_on "remove"
      end
      assert page.has_content?("please")
    end
  end
end
