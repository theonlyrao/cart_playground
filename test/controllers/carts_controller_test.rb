require "test_helper"

class CartsControllerTest < ActionController::TestCase
  test "user can add item to session cart" do
    VCR.use_cassette("ultracart_service#one_item_in_session") do
      get(:add_to_cart, {id: "OM-2"})
      assert_equal ["OM-2"], @controller.session[:cart]
    end
  end
end
