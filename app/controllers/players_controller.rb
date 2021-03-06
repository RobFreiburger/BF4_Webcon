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
      current_user.player_id = @player.id
      current_user.save
      render
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @player = current_user.player
  end

  def update
    @player = current_user.player

    if @player.update(player_params)
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
