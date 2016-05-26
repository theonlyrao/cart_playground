require 'test_helper'

class UserCanAddItemToCartTest < ActionDispatch::IntegrationTest

  def test_user_can_view_cart_with_multiple_items
    VCR.use_cassette("ultracart_service#feature_user_adds_and_views_two_item_cart") do
      visit root_path
      click_on "add one year membership to cart"
      click_on "add lifetime membership to cart"
      click_on "view cart"
      assert_equal cart_path, current_path
      save_and_open_page
      assert page.has_content?("1-year Membership")
      assert page.has_content?("Lifetime Membership")
      assert page.has_content?("2120.00")
    end
  end
end
