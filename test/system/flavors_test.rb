require "application_system_test_case"

class FlavorsTest < ApplicationSystemTestCase
  setup do
    @flavor = flavors(:one)
  end

  test "visiting the index" do
    visit flavors_url
    assert_selector "h1", text: "Flavors"
  end

  test "should create flavor" do
    visit flavors_url
    click_on "New flavor"

    fill_in "Instock", with: @flavor.instock
    fill_in "Name", with: @flavor.name
    fill_in "Quantity", with: @flavor.quantity
    click_on "Create Flavor"

    assert_text "Flavor was successfully created"
    click_on "Back"
  end

  test "should update Flavor" do
    visit flavor_url(@flavor)
    click_on "Edit this flavor", match: :first

    fill_in "Instock", with: @flavor.instock
    fill_in "Name", with: @flavor.name
    fill_in "Quantity", with: @flavor.quantity
    click_on "Update Flavor"

    assert_text "Flavor was successfully updated"
    click_on "Back"
  end

  test "should destroy Flavor" do
    visit flavor_url(@flavor)
    click_on "Destroy this flavor", match: :first

    assert_text "Flavor was successfully destroyed"
  end
end
