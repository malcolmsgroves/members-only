require 'test_helper'

class PostsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hannah)
  end
=begin
  test "cannot make new post if not logged in" do
    log_out
    get new_post_path
    assert_select "a[href=?]", login_path
  end

  test "can make new post if logged in" do
    log_in_as(@user)
    get new_post_path

  end
=end
end
