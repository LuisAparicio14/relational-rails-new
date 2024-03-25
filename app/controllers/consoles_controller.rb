class ConsolesController < ApplicationController
  def index
    @consoles = Console.recently_created
  end

  def show
    @console = Console.find(params[:id])
  end

  def new

  end

  def create
    Console.create!(console_params)
    redirect_to '/consoles'
  end

  def edit
    @console = Console.find(params[:id])
  end

  def update
    @console = Console.find(params[:id])
    @console.update(console_params)
    redirect_to "/consoles/#{@console.id}"
  end

  def destroy
    Console.find(params[:id]).destroy
    redirect_to "/consoles"
  end

  private
  def console_params
    params.permit(:name, :price, :available)
  end
end