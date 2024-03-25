class Game < ApplicationRecord
  belongs_to :console

  def self.game_true
    where(age_verification: true)
  end

  def self.alphabetical_order
    order(name: :asc)
  end

  def self.year_over(threshold)
    where("year_released > ?", threshold)
  end
end 