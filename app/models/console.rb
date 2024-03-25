class Console < ApplicationRecord
  has_many :games, dependent: :destroy

  def self.recently_created
    order(created_at: :desc)
  end

  def game_count
    games.count
  end
end