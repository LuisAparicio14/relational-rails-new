class GamesController < ApplicationController
  def index
    @games = Game.game_true
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update 
    game = Game.find(params[:id])
    game.update(game_params)
    redirect_to "/games/#{game.id}"
  end

  def destroy 
    Game.find(params[:id]).destroy
    redirect_to "/games"
  end

  private
  def game_params
    params.permit(:name, :year_released, :age_verification)
  end
end