# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
@console_1 = Console.create!(name: "Playstation", price: 400, available: true)
@console_2 = Console.create!(name: "Xbox", price: 300, available: true)
@game_1 = @console_1.games.create!(name: "Fifa 24", year_released: 2024, age_verification: false)
@game_2 = @console_2.games.create!(name: "R6", year_released: 2016, age_verification: true)
@game_3 = @console_1.games.create!(name: "COD", year_released: 2014, age_verification: true)

