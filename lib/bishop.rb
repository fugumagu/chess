require_relative 'piece.rb'

class Bishop < Piece
	attr_accessor :unicode

	def initialize(coordinates = [-1, -1], color = nil)
		super
		bishop_moves
		@unicode = color == 'black' ? "\u2657" : "\u265D"
	end

	def bishop_moves
		for i in 1..7
			@moves_diagonal_up_right << [i, i]
			@moves_diagonal_down_left << [-i, -i]
			@moves_diagonal_down_right << [i, -i]
			@moves_diagonal_up_left << [-i, i]
		end
		
		@moves_direction_sets << @moves_diagonal_up_right
		@moves_direction_sets << @moves_diagonal_down_left
		@moves_direction_sets << @moves_diagonal_down_right
		@moves_direction_sets << @moves_diagonal_up_left
	end
end