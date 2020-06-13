require "application_system_test_case"

class MetricsTest < ApplicationSystemTestCase
  test "visiting root and seeing login page if not login" do
    visit root_path
  
    assert_selector "h2", text: "Log in"
  end

  test "can login if credentials are right" do
    email = 'test@email.com'
    password = 'FirstLast'
    
    user = User.create(email: email,
      password: password,
      password_confirmation: password,
      first_name: 'First',
      last_name: 'Last',
      login: 'test',
      address: '282 Kevin Brook, Imogeneborough, CA 58517')

    visit root_path
    assert_selector "h2", text: "Log in"

    fill_in "Email", with: email
    fill_in "Password", with: password

    click_on "Log in"

    assert_text "Metrics"
  end
end
