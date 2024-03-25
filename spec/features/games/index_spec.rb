require 'rails_helper'

RSpec.describe 'games#index', type: :feature do
  before(:each) do
    @console_1 = Console.create!(name: "Playstation", price: 400, available: true)
    @console_2 = Console.create!(name: "Xbox", price: 300, available: true)
    @game_1 = @console_1.games.create!(name: "Fifa 24", year_released: 2024, age_verification: false)
    @game_2 = @console_2.games.create!(name: "R6", year_released: 2016, age_verification: true)
    @game_3 = @console_1.games.create!(name: "COD", year_released: 2014, age_verification: true)
  end

  # User Story 3, Child Index 
  it "games index page" do
    # As a visitor
    # When I visit '/child_table_name'
    visit "/games"
    # Then I see each Child in the system including the Child's attributes
    # (data from each column that is on the child table)
    expect(page).to have_content("R6")
    expect(page).to have_content("2016")
    expect(page).to have_content("true")
  end

  # User Story 8, Child Index Link
  it "link to all pages to index games" do
    # As a visitor
    # When I visit any page on the site
    visit "/games"
    # Then I see a link at the top of the page that takes me to the Child Index
    expect(page).to have_link("Games")
    click_on("Games")
    expect(current_path).to eq("/games")

    visit '/consoles'
    expect(page).to have_link("Games")
    click_on("Games")
    expect(current_path).to eq("/games")
  end

  # User Story 15, Child Index only shows `true` Records 
  it "shows the games that have a age verification of true" do
    # As a visitor
    # When I visit the child index
    visit "/games"
    # Then I only see records where the boolean column is `true`
    expect(page).to_not have_content(@game_1.name)
    expect(page).to have_content(@game_2.name)
    expect(page).to have_content(@game_3.name)
  end

  # User Story 18, Child Update From Childs Index Page 
  it "has edit page for games" do
    # As a visitor
    # When I visit the `child_table_name` index page or a parent `child_table_name` index page
    visit "/games"
    # Next to every child, I see a link to edit that child's info
    within "#game-#{@game_2.id}" do
      expect(page).to have_link("Edit Game: #{@game_2.name}")
    end

    within "#game-#{@game_3.id}" do
      expect(page).to have_link("Edit Game: #{@game_3.name}")
    end

    expect(page).to_not have_content("#{@game_1.name}")
    # When I click the link
    click_link("Edit Game: #{@game_2.name}")
    # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14
    expect(current_path).to eq("/games/#{@game_2.id}/edit")
  end

  # User Story 23, Child Delete From Childs Index Page 
  it "can delete a game" do
    # As a visitor
    # When I visit the `child_table_name` index page or a parent `child_table_name` index page
    visit "/games"
    # Next to every child, I see a link to delete that child
    within "#game-#{@game_2.id}" do
      expect(page).to have_link("Delete Game")
      # When I click the link
      click_link("Delete Game")
    end
    # I should be taken to the `child_table_name` index page where I no longer see that child
    expect(current_path).to eq("/games")
    expect(page).to_not have_content(@game_2.name)
  end
end