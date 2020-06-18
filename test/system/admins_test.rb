require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
  test "admin can watch and edit metrics of user" do
    # Add user
    password_user = Faker::Number.number(digits: 10)    
    user = User.create(
      password: password_user,
      password_confirmation: password_user,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      login: Faker::DcComics.unique.hero,
      address: Faker::Address.full_address,
      has_default_password: false
    )

    # Add user metrics
    metric = Metric.create(
      cold: 2,
      hot: 1,
      user_id: user.id
    )
    
    # Add admin
    login_admin = Faker::DcComics.unique.hero
    password_admin = Faker::Number.number(digits: 10)
    
    User.create(
      password: password_admin,
      password_confirmation: password_admin,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      login: login_admin,
      address: Faker::Address.full_address,
      is_admin: true,
      has_default_password: false
    )

    visit index_path
    assert_text "Log in"

    fill_in "Login", with: login_admin
    fill_in "Password", with: password_admin
    click_on "Log in"
    assert_selector "h1", text: "Admin Interface"

    find('tbody td:nth-child(1)', text: user.id).first(:xpath, ".//..").click_link('Show')
    assert_selector "h1", text: "Metrics"
    assert_selector "tbody > tr:nth-child(1) > td:nth-child(2)", text: metric.cold
    assert_selector "tbody > tr:nth-child(1) > td:nth-child(3)", text: metric.hot

    click_on "Edit"

    assert_selector "h1", text: "Edit Metric"

    new_cold = 8
    new_hot = 9

    fill_in "Cold", with: new_cold
    fill_in "Hot", with: new_hot
    click_on "Update Metric"

    assert_selector "h1", text: "Metrics"
    assert_selector "tbody > tr:nth-child(1) > td:nth-child(2)", text: new_cold
    assert_selector "tbody > tr:nth-child(1) > td:nth-child(3)", text: new_hot

    take_failed_screenshot
  end

  test "admin can watch statistics" do
    # Add users
    password_user = Faker::Number.number(digits: 10)
    
    counter = 5
    counter.times do |n|
      user = User.create(
        password: password_user,
        password_confirmation: password_user,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        login: "login_user#{n}",
        address: Faker::Address.full_address,
        has_default_password: false
      )

      # Add user metrics
      metric = Metric.create(
        cold: n + 100,
        hot: 100 - n,
        user_id: user.id
      )
    end

    # Add admin
    login_admin = Faker::DcComics.unique.hero
    password_admin = Faker::Number.number(digits: 10)
    
    User.create(
      password: password_admin,
      password_confirmation: password_admin,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      login: login_admin,
      address: Faker::Address.full_address,
      is_admin: true,
      has_default_password: false
    )

    visit index_path
    assert_text "Log in"

    fill_in "Login", with: login_admin
    fill_in "Password", with: password_admin
    click_on "Log in"
    assert_selector "h1", text: "Admin Interface"

    click_on "Consumption statistics"
    assert_selector "h1", text: "Statistics"

    click_on "Cold water consumption"

    assert_selector "tbody > tr:nth-child(1) > td:nth-child(1)" 
    user_cold_1 = User.select(:id).where(login: "login_user#{counter - 1}").take
    user_cold_2 = User.select(:id).where(login: "login_user#{counter - 2}").take
    user_cold_3 = User.select(:id).where(login: "login_user#{counter - 3}").take
    
    assert_selector "tbody > tr:nth-child(1) > td:nth-child(1)", text: user_cold_1.id
    assert_selector "tbody > tr:nth-child(2) > td:nth-child(1)", text: user_cold_2.id
    assert_selector "tbody > tr:nth-child(3) > td:nth-child(1)", text: user_cold_3.id

    visit show_statistics_path
    click_on "Hot water consumption"
    user_hot_1 = User.select(:id).where(login: "login_user#{0}").take
    user_hot_2 = User.select(:id).where(login: "login_user#{1}").take
    user_hot_3 = User.select(:id).where(login: "login_user#{2}").take

    assert_selector "tbody > tr:nth-child(1) > td:nth-child(1)", text: user_hot_1.id
    assert_selector "tbody > tr:nth-child(2) > td:nth-child(1)", text: user_hot_2.id
    assert_selector "tbody > tr:nth-child(3) > td:nth-child(1)", text: user_hot_3.id

    take_failed_screenshot
  end
end
