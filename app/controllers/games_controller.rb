class GamesController < ApplicationController
  def conduct_game
    game_id = session[:game_id]
    start_loc = params[:start_loc].split('').map(&:to_i)
    end_loc = params[:end_loc].split('').map(&:to_i)
    piece_id = Move.where(position: start_loc).first.id
    new_loc = end_loc*'' # turns array of two numbers into string
    midpoint = find_square_between_origin_and_destination(start_loc, end_loc)
    opponent_piece_id = Move.where(position: midpoint).first.id

    if empty_space?(end_loc) && valid_move?(start_loc, end_loc)
      move_distance = move_distance_calculation(start_loc, end_loc)
      if move_distance == 1
          Move.create(piece_id: piece_id,  game_id: game_id, position: new_loc)
      elsif move_distance == 2
        if opponent_in_jump_midpoint?(start_loc, end_loc)
          Move.create(piece_id: piece_id, game_id: game_id, position: new_loc)
          Move.create(piece_id: opponent_piece_id, game_id: game_id, position: '')
          if game_over?(opponent_piece_id, game_id)
            # End game route
          else
            # Continue game route
          end
        else
          @error = "Invalid move!"
        end
      else
        @error = "Invalid move!"
      end
    end
  end
end
