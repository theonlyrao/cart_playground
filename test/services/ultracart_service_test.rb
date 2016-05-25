require "test_helper"

class UltracartServiceTest < Minitest::Test
  def test_service_can_get_item_info
    VCR.use_cassette("ultracart_service#one_year_membership") do
      uc = UltracartService.new
      item_info = uc.get_item("OM-2")
      assert_equal item_info["description"], "1-year Membership"
      assert_equal item_info["cost"], 120
    end
  end

  def test_service_can_add_item_to_cart
    VCR.use_cassette("ultracart_service#two_item_cart") do
      uc = UltracartService.new
      one_year = uc.get_item("OM-2")
      cart_info = uc.add_item(one_year)

      assert_equal 120, cart_info["total"]

      lifetime = uc.get_item("OM-5")
      cart_info = uc.add_item(lifetime)

      assert_equal 2120, cart_info["total"]
    end
  end
end
