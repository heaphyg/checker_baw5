class GameRoomsController < ApplicationController

  def show
    @game = GameRoom.find(params[:id])
  end

  def create
    @room = GameRoom.new(game_room_params)
    @game = Game.new

    if @room.save && @game.save
      session[:room_id] = @room.id
      session[:game_id] = @game.id
      Game.intiialize_board(@game.id)
      redirect_to game_room_path(@room)
    else
      redirect_to users_path
    end
  end

  private

  def game_room_params
    params.require(:game_room).permit(:owner, :room_name)
  end


end
