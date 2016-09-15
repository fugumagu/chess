require_relative 'piece.rb'

class Knight < Piece
	attr_accessor :unicode

	def initialize(location = [-1, -1], color = nil)
		super
		knight_moves
		@unicode = color == 'black' ? "\u2658" : "\u265E"
	end

	def knight_moves

		@moves_direction_sets << [[1, 2]]
		@moves_direction_sets << [[2, 1]]
		@moves_direction_sets << [[2, -1]]
		@moves_direction_sets << [[1, -2]]
		@moves_direction_sets << [[-1, -2]]
		@moves_direction_sets << [[-2, -1]]
		@moves_direction_sets << [[-2, 1]]
		@moves_direction_sets << [[-1, 2]]
	end
end