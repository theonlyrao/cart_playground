require "test_helper"

class CartMakerTest < ActiveSupport::TestCase
  def test_cart_maker_makes_cart_items
    VCR.use_cassette("ultracart_service#feature_two_items_in_cart") do
      cart_maker = CartMaker.new(["OM-2", "OM-5"])
      
      assert_equal("1-year Membership", cart_maker.items.first.description)
      assert_equal("Lifetime Membership", cart_maker.items.last.description)
      assert_equal 2120.00, cart_maker.properties.total
    end
  end

  def test_cart_maker_works_with_no_items
    cart_maker = CartMaker.new(nil)

    assert_equal true, cart_maker.items.nil?
  end

end

