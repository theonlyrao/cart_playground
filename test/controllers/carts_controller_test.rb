require "test_helper"

class CartsControllerTest < ActionController::TestCase
  test "user can add item to session cart" do
    get(:add_to_cart, {id: "OM-2"})
    assert_equal ["OM-2"], @controller.session[:cart]
  end

  test "user can add item to actual cart" do
    
  end
  

end
