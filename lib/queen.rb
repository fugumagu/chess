require_relative 'piece.rb'

class Queen < Piece
	attr_accessor :unicode

	def initialize(coordinates = [-1, -1], color = nil)
		super
		queen_moves
		@unicode = color == 'black' ? "\u2655" : "\u265B"
	end

	def queen_moves
		for i in 1..7
			@moves_diagonal_up_right << [i, i]
			@moves_diagonal_down_left << [-i, -i]
			@moves_diagonal_down_right  << [i, -i]
			@moves_diagonal_up_left << [-i, i]
			@moves_down << [i, 0]
			@moves_left  << [-i, 0]
			@moves_right  << [0, i]
			@moves_down << [0, -i]
		end

		@moves_direction_sets << @moves_diagonal_up_right
		@moves_direction_sets << @moves_right
		@moves_direction_sets << @moves_diagonal_down_right 
		@moves_direction_sets << @moves_down 
		@moves_direction_sets << @moves_diagonal_down_left
		@moves_direction_sets << @moves_left 
		@moves_direction_sets << @moves_diagonal_up_left 
		@moves_direction_sets << @moves_up
	end
end