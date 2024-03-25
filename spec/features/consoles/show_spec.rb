require 'rails_helper'

RSpec.describe 'consoles#show', type: :feature do
  before(:each) do
    @console_1 = Console.create!(name: "Playstation", price: 400, available: true)
    @console_2 = Console.create!(name: "Xbox", price: 300, available: true)
    @game_1 = @console_1.games.create!(name: "Fifa 24", year_released: 2024, age_verification: false)
    @game_2 = @console_2.games.create!(name: "R6", year_released: 2016, age_verification: true)
    @game_3 = @console_1.games.create!(name: "COD", year_released: 2014, age_verification: true)
  end

  # User Story 2, Parent Show 
  it "consoles with the id and attributes" do
    # As a visitor
    # When I visit '/parents/:id'
    visit "/consoles/#{@console_1.id}"
    # Then I see the parent with that id including the parent's attributes
    # (data from each column that is on the parent table)
    expect(page).to have_content(@console_1.name)
    expect(page).to have_content(@console_1.price)
    expect(page).to have_content(@console_1.available)
  end

  # User Story 7, Parent Child Count
  it "can display the count of games" do
    # As a visitor
    # When I visit a parent's show page
    visit "/consoles/#{@console_1.id}"
    # I see a count of the number of children associated with this parent
    expect(page).to have_content("Games Count: 2")
  end

  # User Story 10, Parent Child Index Link
  it "has a link to the list of games" do
    # As a visitor
    # When I visit a parent show page ('/parents/:id')
    visit "/consoles/#{@console_1.id}"
    # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
    expect(page).to have_link("Games List")
    click_link("Games List")
    expect(current_path).to eq("/consoles/#{@console_1.id}/games")
  end
  
  # User Story 12, Parent Update 
  it "displays the updated info of the console" do
    # As a visitor
    # When I visit a parent show page
    visit "/consoles/#{@console_1.id}"
    # Then I see a link to update the parent "Update Parent"
    expect(page).to have_content("Update Console")
    # When I click the link "Update Parent"
    click_link("Update Console")
    # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
    expect(current_path).to eq("/consoles/#{@console_1.id}/edit")
    # When I fill out the form with updated information
    fill_in "name", with: "PS3"
    fill_in "price", with: "50"
    fill_in "available", with: "false"
    # And I click the button to submit the form
    click_button("Submit")
    # Then a `PATCH` request is sent to '/parents/:id',
    # the parent's info is updated,
    # and I am redirected to the Parent's Show page where I see the parent's updated info
    expect(current_path).to eq("/consoles/#{@console_1.id}")
    expect(page).to have_content("PS3")
    expect(page).to have_content("50")
    expect(page).to have_content("false")
  end

  # User Story 19, Parent Delete 
  it "Delete a Console" do
    # As a visitor
    # When I visit a parent show page
    visit "/consoles/#{@console_1.id}"
    # Then I see a link to delete the parent
    expect(page).to have_link("Delete Console")
    # When I click the link "Delete Parent"
    click_link("Delete Console")
    # Then a 'DELETE' request is sent to '/parents/:id',
    # the parent is deleted, and all child records are deleted
    # and I am redirected to the parent index page where I no longer see this parent
    expect(current_path).to eq("/consoles")
    expect(page).to_not have_content(@console_1.name)
  end
end