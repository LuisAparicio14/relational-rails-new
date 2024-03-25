require 'rails_helper'

RSpec.describe 'games#show', type: :feature do
  before(:each) do
    @console_1 = Console.create!(name: "Playstation", price: 400, available: true)
    @console_2 = Console.create!(name: "Xbox", price: 300, available: true)
    @game_1 = @console_1.games.create!(name: "Fifa 24", year_released: 2024, age_verification: false)
    @game_2 = @console_2.games.create!(name: "R6", year_released: 2016, age_verification: true)
    @game_3 = @console_1.games.create!(name: "COD", year_released: 2014, age_verification: true)
  end
  
  # User Story 4, Child Show 
  it "displays the games attributes" do
    # As a visitor
    # When I visit '/child_table_name/:id'
    visit "/games/#{@game_1.id}"
    # Then I see the child with that id including the child's attributes
    # (data from each column that is on the child table)
    expect(page).to have_content(@game_1.name)
    expect(page).to have_content(@game_1.year_released)
    expect(page).to have_content(@game_1.age_verification)
    
    visit "/games/#{@game_2.id}"
    expect(page).to have_content(@game_2.name)
    expect(page).to have_content(@game_2.year_released)
    expect(page).to have_content(@game_2.age_verification)
  end

  # User Story 14, Child Update 
  it "can update games" do
    # As a visitor
    # When I visit a Child Show page
    visit "/games/#{@game_1.id}"
    # Then I see a link to update that Child "Update Child"
    expect(page).to have_link("Update Game")
    # When I click the link
    click_link("Update Game")
    # I am taken to '/child_table_name/:id/edit'
    expect(current_path).to eq("/games/#{@game_1.id}/edit")
    # where I see a form to edit the child's attributes:
    fill_in "name", with: "GTA V"
    fill_in "year_released", with: "2016"
    fill_in "age_verification", with: "true"
    # When I click the button to submit the form "Update Child"
    click_button("Update Game")
    # Then a `PATCH` request is sent to '/child_table_name/:id',
    expect(current_path).to eq("/games/#{@game_1.id}")
    # the child's data is updated,
    # and I am redirected to the Child Show page where I see the Child's updated information
    expect(page).to have_content("GTA V")
    expect(page).to have_content("2016")
    expect(page).to have_content("true")
  end
  
  # User Story 20, Child Delete 
  it "Delete a game" do
    # As a visitor
    # When I visit a child show page
    visit "/games/#{@game_1.id}"
    # Then I see a link to delete the child "Delete Child"
    expect(page).to have_link("Delete Game")
    # When I click the link
    click_link("Delete Game")
    # Then a 'DELETE' request is sent to '/child_table_name/:id',
    # the child is deleted,
    # and I am redirected to the child index page where I no longer see this child
    expect(current_path).to eq("/games")
    expect(page).to_not have_content("#{@game_1.name}")
  end
end
