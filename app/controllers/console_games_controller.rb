class ConsoleGamesController < ApplicationController
  def index
    @console = Console.find(params[:id])
    
    if params[:order] == "alphabetical"
      @console_games = @console.games.alphabetical_order
    elsif params[:threshold]
      @console_games = @console.games.year_over(params[:threshold])
    else
      @console_games = @console.games
    end
  end

  def new
    @console = Console.find(params[:id])
  end

  def create
    console = Console.find(params[:id])
    games = console.games.create!(console_game_params)
    redirect_to "/consoles/#{console.id}/games"
  end

  private
  def console_game_params
    params.permit(:name, :year_released, :age_verification)
  end
end