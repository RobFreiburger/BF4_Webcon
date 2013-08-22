class PlayersController < ApplicationController
  before_action :signed_in_user
  before_action :is_verified
  before_action :is_admin, only: [:index, :destroy]

  def index
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:success] = "Your Origin ID has been whitelisted."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @player.update_parameters(player_params)
      flash[:success] = 'Your Origin ID has been updated.'
      redirect_to(root_path)
    else
      render 'edit'
    end
  end

  def destroy
    Player.find(params[:id]).destroy
    flash[:success] = "Player deleted from database."
    redirect_to players_path
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end

  def is_verified
    redirect_to(root_path) unless current_user.is_verified?
  end

  def is_admin
    redirect_to(root_path) unless current_user.is_admin?
  end
end
