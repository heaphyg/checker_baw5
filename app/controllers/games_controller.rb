class GamesController < ApplicationController
  def create
    Game.intiialize_board
  end

  def update
    game_id = session[:game_id]
    start_loc = params[:start_loc]
    end_loc = params[:end_loc]
    unique_piece_id = param[:unique_piece_id]
    midpoint = Game.find_square_between_origin_and_destination(start_loc, end_loc)

    if Game.empty_space?(end_loc) && Game.valid_move?(start_loc, end_loc)
      move_distance = Game.move_distance_calculation(start_loc, end_loc)

      if move_distance == 1
          Board.where(coord: start_loc, game_id: game_id).first.is_occupied = false
          Board.where(coord: end_loc, game_id: game_id).first.is_occupied = true
          Piece.where(unique_piece_id: unique_piece_id).first.location = end_loc

          return 'true'
      elsif move_distance == 2
        if Game.opponent_in_jump_midpoint?(start_loc, end_loc)
          Board.where(coord: start_loc, game_id: game_id).first.is_occupied = false
          Board.where(coord: end_loc, game_id: game_id).first.is_occupied = true
          Piece.where(unique_piece_id: unique_piece_id).first.location = end_loc

          Board.where(coord: midpoint, game_id: game_id).first.is_occupied = false
          Piece.where(position: midpoint).first.location = ''

          return 'true'
        else
          # @error = "Invalid move!"
          return 'false'
        end
      else
        # @error = "Invalid move!"
        return 'false'
      end
    end
  end
end
