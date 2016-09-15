require_relative 'piece.rb'

class Pawn < Piece
	attr_accessor :unicode

	def initialize(coordinates = [0, 0], color = white)
		super
		pawn_moves
		@unicode = color == 'black' ? "\u2659" : "\u265F"
	end

	def pawn_moves
		if color == 'black'
			@moves_up << [0, -1]
		else
			@moves_up << [0, 1]
		end
		@moves_direction_sets << @moves_up
	end
end