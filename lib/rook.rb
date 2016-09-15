require_relative 'piece.rb'

class Rook < Piece
	attr_accessor :unicode

	def initialize(coordinates = [-1, -1], color = nil)
		super
		rook_moves
		@unicode = color == 'black' ? "\u2656" : "\u265C"
	end

	def rook_moves
		for i in 1..7
			@moves_right << [i, 0]
			@moves_left << [-i, 0]
			@moves_up << [0, i]
			@moves_down << [0, -i]
		end
		@moves_direction_sets << @moves_right
		@moves_direction_sets << @moves_left
		@moves_direction_sets << @moves_up
		@moves_direction_sets << @moves_down
	end
end