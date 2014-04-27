class GamesController < ApplicationController
  def update
    room_id = session[:room_id]
    @room = GameRoom.find(room_id)
    game_id = session[:game_id]
    start_loc = params[:start_loc]
    end_loc = params[:end_loc]
    unique_piece_id = params[:unique_piece_id]
    midpoint = Game.find_square_between_origin_and_destination(start_loc, end_loc)

    if Game.empty_space?(end_loc) #&& Game.valid_move?(start_loc, end_loc, unique_piece_id)
      move_distance = Game.move_distance_calculation(start_loc, end_loc, unique_piece_id)
      if (move_distance.abs == 1) && Game.valid_move?(start_loc, end_loc, unique_piece_id)
          Board.where(coord: start_loc, game_id: game_id).first.update(is_occupied: false)
          Board.where(coord: end_loc, game_id: game_id).first.update(is_occupied: true)
          Piece.where(unique_piece_id: unique_piece_id, game_id: game_id).first.update(location: end_loc)

          # puts '==========================='
          # puts 'This is true, yes you can make this basic ass move'
          # puts '==========================='
          return 'true'
      elsif (move_distance.abs == 2) && Game.valid_move?(start_loc, end_loc, unique_piece_id)
        if Game.opponent_in_jump_midpoint?(start_loc, end_loc, unique_piece_id)
          Board.where(coord: start_loc, game_id: game_id).first.update(is_occupied: false)
          Board.where(coord: end_loc, game_id: game_id).first.update(is_occupied: true)
          Piece.where(unique_piece_id: unique_piece_id, game_id: game_id).first.update(location: end_loc)

          Board.where(coord: midpoint, game_id: game_id).first.update(is_occupied: false)
          Piece.where(location: midpoint, game_id: game_id).first.update(location: '')

          # puts '==========================='
          # puts 'This is true, yes you can jump'
          # puts '==========================='
          return 'true'
        else
          # puts '==========================='
          # puts 'This is false, you cannot make this jump'
          # puts '==========================='
          # @error = "Can't jump this space!"
          return 'false'
        end
      else
        # puts '==========================='
        # puts "This is false, wrong number of moves: #{move_distance}"
        # puts '==========================='
        # @error = "Wrong number of moves!"
        return 'false'
      end
    else
      # puts '==========================='
      # puts 'This is false, your destination is occupied'
      # puts '==========================='
      # @error = "Destination is occupied!"
      return false
    end
  end
end
