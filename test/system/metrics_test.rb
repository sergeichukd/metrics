require "application_system_test_case"

class MetricsTest < ApplicationSystemTestCase
  setup do
    @metric = metrics(:one)
  end

  test "visiting the index" do
    visit metrics_url
    assert_selector "h1", text: "Metrics"
  end

  test "creating a Metric" do
    visit metrics_url
    click_on "New Metric"

    fill_in "Cold", with: @metric.cold
    fill_in "Hot", with: @metric.hot
    click_on "Create Metric"

    assert_text "Metric was successfully created"
    click_on "Back"
  end

  test "updating a Metric" do
    visit metrics_url
    click_on "Edit", match: :first

    fill_in "Cold", with: @metric.cold
    fill_in "Hot", with: @metric.hot
    click_on "Update Metric"

    assert_text "Metric was successfully updated"
    click_on "Back"
  end

  test "destroying a Metric" do
    visit metrics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Metric was successfully destroyed"
  end
end
