require 'rails_helper'

RSpec.describe Console, type: :model do
  describe "relationships" do
    it {should have_many :games}
  end

  before(:each) do
    @console_1 = Console.create!(name: "Playstation", price: 400, available: true)
    @console_2 = Console.create!(name: "Xbox", price: 300, available: true)
  end

  it "recently created" do
    expect(Console.recently_created.to_a.reverse).to eq([@console_1, @console_2])
  end

  describe "#instance methods" do
    it "#game_count" do
      console_1 = Console.create!(name: "Playstation", price: 400, available: true)
      game_1 = console_1.games.create!(name: "Fifa 24", year_released: 2024, age_verification: false)
      game_3 = console_1.games.create!(name: "COD", year_released: 2014, age_verification: true)

      expect(console_1.game_count).to eq(2)
    end
  end
end