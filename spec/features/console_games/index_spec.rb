require 'rails_helper'

RSpec.describe 'console_games#index', type: :feature do
  before(:each) do
    @console_1 = Console.create!(name: "Playstation", price: 400, available: true)
    @console_2 = Console.create!(name: "Xbox", price: 300, available: true)
    @game_1 = @console_1.games.create!(name: "Fifa 24", year_released: 2024, age_verification: false)
    @game_2 = @console_2.games.create!(name: "R6", year_released: 2016, age_verification: true)
    @game_3 = @console_1.games.create!(name: "COD", year_released: 2014, age_verification: true)

  end

  # User Story 5, Parent Children Index 
  it "each console associated with each game" do
    # As a visitor
    # When I visit '/parents/:parent_id/child_table_name'
    visit "/consoles/#{@console_1.id}/games"
    # Then I see each Child that is associated with that Parent with each Child's attributes
    # (data from each column that is on the child table)
    within "#console_game-#{@game_1.id}" do
      expect(page).to have_content(@game_1.name)
      expect(page).to have_content(@game_1.year_released)
      expect(page).to have_content(@game_1.age_verification)
    end

    within "#console_game-#{@game_3.id}" do
      expect(page).to have_content(@game_3.name)
      expect(page).to have_content(@game_3.year_released)
      expect(page).to have_content(@game_3.age_verification)
    end
  end

  # User Story 13, Parent Child Creation 
  it "can create a new Game" do
    # As a visitor
    # When I visit a Parent Children Index page
    visit "/consoles/#{@console_1.id}/games"
    # Then I see a link to add a new adoptable child for that parent "Create Child"
    expect(page).to have_link("Create Game")
    # When I click the link
    click_link("Create Game")
    # I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
    expect(current_path).to eq("/consoles/#{@console_1.id}/games/new")
    # When I fill in the form with the child's attributes:
    fill_in "name", with: "GTA V"
    fill_in "year_released", with: "2016"
    fill_in "age_verification", with: "true"
    # And I click the button "Create Child"
    click_button("Create Game")
    # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
    expect(current_path).to eq("/consoles/#{@console_1.id}/games")
    # a new child object/row is created for that parent,
    # and I am redirected to the Parent Childs Index page where I can see the new child listed
    expect(page).to have_content("GTA V")
    expect(page).to have_content("2016")
    expect(page).to have_content("true")
  end

  # User Story 16, Sort Parent's Children in Alphabetical Order by name 
  it "all of the games in alphabetical order" do
    # As a visitor
    # When I visit the Parent's children Index Page
    visit "/consoles/#{@console_1.id}/games"
    # Then I see a link to sort children in alphabetical order
    expect(page).to have_link("Alphabetical Order")
    # When I click on the link
    click_link("Alphabetical Order")
    # I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
    expect(@game_3.name).to appear_before(@game_1.name)
    expect(@game_1.name).to_not appear_before(@game_3.name)
  end
  
  # User Story 21, Display Records Over a Given Threshold 
  it "displays record of games with the respective threshold" do
    # As a visitor
    # When I visit the Parent's children Index Page
    visit "/consoles/#{@console_1.id}/games"
    # I see a form that allows me to input a number value
    within '.game_threshold' do
      # When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'
      fill_in "Games year released", with: "2017"

      click_button("Submit")
    end
    # Then I am brought back to the current index page with only the records that meet that threshold shown.
    expect(current_path).to eq("/consoles/#{@console_1.id}/games")
    expect(page).to have_content(@game_1.name)
    expect(page).to_not have_content(@game_3.name)
  end
end