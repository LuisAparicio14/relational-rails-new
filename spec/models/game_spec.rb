require 'rails_helper'

RSpec.describe Game, type: :model do
  before(:each) do
    @console_1 = Console.create!(name: "Playstation", price: 400, available: true)
    @console_2 = Console.create!(name: "Xbox", price: 300, available: true)
    @game_1 = @console_1.games.create!(name: "Fifa 24", year_released: 2024, age_verification: false)
    @game_2 = @console_2.games.create!(name: "R6", year_released: 2016, age_verification: true)
    @game_3 = @console_1.games.create!(name: "COD", year_released: 2014, age_verification: true)
  end
  describe 'relationships' do
    it { should belong_to(:console)}
  end

  it "only have the true for age verification" do
    expect(Game.game_true).to eq([@game_2, @game_3])
  end

  it "#year_over" do
    expect(Game.year_over(2016)).to eq([@game_1])
  end
end