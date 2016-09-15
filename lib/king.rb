require_relative 'piece.rb'

class King < Piece
	attr_accessor :unicode

	def initialize(coordinates = [-1, -1], color = nil)
		super
		king_moves
		@unicode = color == 'black' ? "\u2654" : "\u265A"
	end

	def king_moves
		@moves_diagonal_up_right << [1, 1]
		@moves_up << [1, 0]
		@moves_diagonal_down_right << [1, -1]
		@moves_down << [0, -1]
		@moves_diagonal_down_left << [-1, -1]
		@moves_left << [-1, 0]
		@moves_diagonal_up_left << [-1, 1]
		@moves_up << [0, 1]

		@moves_direction_sets << @moves_diagonal_up_right
		@moves_direction_sets << @moves_up
		@moves_direction_sets << @moves_diagonal_down_right 
		@moves_direction_sets << @moves_down 
		@moves_direction_sets << @moves_diagonal_down_left
		@moves_direction_sets << @moves_left 
		@moves_direction_sets << @moves_diagonal_up_left 
		@moves_direction_sets << @moves_up
	end
end