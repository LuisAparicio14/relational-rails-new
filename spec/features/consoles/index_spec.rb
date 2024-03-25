require 'rails_helper'

RSpec.describe 'console#index', type: :feature do
  before(:each) do
    @console_1 = Console.create!(name: "Playstation", price: 400, available: true)
    @console_2 = Console.create!(name: "Xbox", price: 300, available: true)
    @console_3 = Console.create!(name: "Nintendo", price: 200, available: false)
  end

  # User Story 1, Parent Index 
  it "name of each console" do
    # For each parent table
    # As a visitor
    # When I visit '/parents'
    visit '/consoles'
    # Then I see the name of each parent record in the system
    expect(page).to have_content(@console_1.name)
    expect(page).to have_content(@console_2.name)
    expect(page).to have_content(@console_3.name)
  end

  # User Story 6, Parent Index sorted by Most Recently Created 
  it "the console that is most recently created" do
    # As a visitor
    # When I visit the parent index,
    visit '/consoles'
    # I see that records are ordered by most recently created first
    # And next to each of the records I see when it was created
    expect(@console_2.name).to appear_before(@console_1.name)

    within "#console-#{@console_1.id}" do
      expect(page).to have_content(@console_1.created_at)
    end
    within "#console-#{@console_2.id}" do
      expect(page).to have_content(@console_2.created_at)
    end
  end

  # User Story 9, Parent Index Link
  it "has a link to the consoles and games pages" do
    # As a visitor
    # When I visit any page on the site
    visit '/consoles'
    # Then I see a link at the top of the page that takes me to the Parent Index
    expect(page).to have_link("Consoles")
    click_on("Consoles")
    expect(current_path).to eq('/consoles')

    visit "/games"
    expect(page).to have_link("Consoles")
    click_on("Consoles")
    expect(current_path).to eq("/consoles")
  end

  # User Story 11, Parent Creation 
  it "can create a new console" do
    # As a visitor
    # When I visit the Parent Index page
    visit '/consoles'
    # Then I see a link to create a new Parent record, "New Parent"
    expect(page).to have_link("New Console")
    # When I click this link
    click_link("New Console")
    # Then I am taken to '/parents/new' where I  see a form for a new parent record
    expect(current_path).to eq("/consoles/new")
    # When I fill out the form with a new parent's attributes:
    fill_in "name", with: "PS4"
    fill_in "price", with: "150"
    fill_in "available", with: "true"
    # And I click the button "Create Parent" to submit the form
    click_button("Create Console")
    # Then a `POST` request is sent to the '/parents' route,
    # a new parent record is created,
    # and I am redirected to the Parent Index page where I see the new Parent displayed.
    expect(current_path).to eq('/consoles')
    expect(page).to have_content("Name: PS4")
  end

  # User Story 17, Parent Update From Parent Index Page 
  it "has edit page for a console" do
    # As a visitor
    # When I visit the parent index page
    visit '/consoles'
    # Next to every parent, I see a link to edit that parent's info
    within "#console-#{@console_1.id}" do
      expect(page).to have_link("Edit Console: #{@console_1.name}")
    end
    within "#console-#{@console_2.id}" do
      expect(page).to have_link("Edit Console: #{@console_2.name}")
    end
    within "#console-#{@console_3.id}" do
      expect(page).to have_link("Edit Console: #{@console_3.name}")
    end
    # When I click the link
    click_link("Edit Console: #{@console_1.name}")
    # I should be taken to that parent's edit page where I can update its information just like in User Story 12
    expect(current_path).to eq("/consoles/#{@console_1.id}/edit")
  end

  # User Story 22, Parent Delete From Parent Index Page 
  it "can delete a console" do
    # As a visitor
    # When I visit the parent index page
    visit "/consoles"
    # Next to every parent, I see a link to delete that parent
    within "#console-#{@console_1.id}" do
      expect(page).to have_link("Delete Console")
      # When I click the link
      click_link("Delete Console")
    end
    # I am returned to the Parent Index Page where I no longer see that parent
    expect(current_path).to eq("/consoles")
    expect(page).to_not have_content(@console_1.name)
  end
end