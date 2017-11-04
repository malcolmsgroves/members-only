require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Mr Groves", email: "close@to.you",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "email should not be empty" do
    @user.email = '          '
    assert_not @user.valid?
  end

  test "name should not be empty" do
    @user.name = '            '
    assert_not @user.valid?
  end

  test "password must be at least 6 characters" do
    @user.password = 'short'
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "authenticated? should return true for a user with correct digest" do
    @user.remember
    assert_not @user.authenticated?(:remember, '')
    assert @user.authenticated?(:remember, @user.remember_token)
  end
end
