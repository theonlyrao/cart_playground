require 'test_helper'

class UserCanLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "user can login using oauth through github" do
    visit root_path
    click_on "Login"
    assert_equal root_path, current_path
  end
end
