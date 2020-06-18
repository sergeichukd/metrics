require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should save 10 users if data correct' do
    10.times do |n|
      user = User.new
      user.password = Faker::Number.number(digits: 10)
      user.password_confirmation = user.password
      user.first_name = Faker::Name.first_name 
      user.last_name = Faker::Name.last_name
      user.login = "#{n}#{Faker::String.random(length: 6..12)}"
      user.address = Faker::Address.full_address

      assert user.save
    end
  end

  test 'should not save user if login is already taken' do
    password = Faker::Number.number(digits: 10)
    login = Faker::DcComics.hero
    first_first_name = Faker::Name.first_name
    first_last_name = Faker::Name.last_name
    first_address = Faker::Address.full_address

    second_first_name = Faker::Name.first_name
    second_last_name = Faker::Name.last_name
    second_address = Faker::Address.full_address

    User.create(password: password, 
                password_confirmation: password, login: login, 
                first_name: first_first_name, last_name: first_last_name, 
                address: first_address)

    user_with_same_login = User.new(password: password,
                                    password_confirmation: password, login: login,
                                    first_name: second_first_name, last_name: second_last_name, address: second_address)

    assert_not user_with_same_login.save, 'Login must be unique'
  end
end
