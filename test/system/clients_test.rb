require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  test "visiting root and seeing login page if not login" do
    visit root_path
  
    assert_text "Log in"
    take_failed_screenshot
  end

  test "first user login and change password" do
    # Create user by admin
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

    click_on "Add new user"
    assert_selector "h1", text: "New user"

    first_name_user = Faker::Name.first_name
    last_name_user = Faker::Name.last_name
    login_user = Faker::DcComics.unique.hero

    fill_in "First name", with: first_name_user
    fill_in "Last name", with: last_name_user
    fill_in "Login", with: login_user
    fill_in "Address", with: Faker::Address.full_address
    click_on "Create User"    
  
    assert_text "User was successfully created."

    click_on "Sign out"

    # Created user first log in
    visit root_path
    assert_text "Log in"

    fill_in "Login", with: login_user
    fill_in "Password", with: "#{first_name_user}#{last_name_user}"
    click_on "Log in"

    assert_selector "h1", text: "Change your password"

    fill_in "Password", with: "123456789"
    fill_in "Password confirmation", with: "123456789"
    click_on "Change password"

    assert_selector "h1", text: "Metrics"
    assert_text "Hello #{login_user}"
    take_failed_screenshot
  end

  test "user can create new metrics and only one time in a month" do
    login = Faker::DcComics.unique.hero
    password = Faker::Number.number(digits: 10)
    
    User.create(
      password: password,
      password_confirmation: password,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      login: login,
      address: Faker::Address.full_address,
      has_default_password: false
    )

    visit root_path
    assert_text "Log in"

    fill_in "Login", with: login
    fill_in "Password", with: password
    click_on "Log in"

    click_on "New Metric"
    assert_selector "h1", text: "New Metric"

    # Make first metric in a month
    fill_in "Cold", with: 3
    fill_in "Hot", with: 2
    click_on "Create Metric"

    assert_text "Metric was successfully created."
    assert_selector "h1", text: "Metrics"

    # Make second metric in a month
    click_on "New Metric"
    assert_selector "h1", text: "New Metric"

    fill_in "Cold", with: 4
    fill_in "Hot", with: 3
    click_on "Create Metric"
    assert_selector "h1", text: "New Metric"
    assert_text "You've already have actual records for current month"
    take_failed_screenshot
  end
end
