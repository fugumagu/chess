class Piece
	attr_accessor :coordinates, :moves_direction_sets, :color, :moves_diagonal_up_right, 
		:moves_right, :moves_diagonal_down_right, :moves_down, :moves_diagonal_down_left, 
		:moves_left, :moves_diagonal_up_left, :moves_up, :has_moved

	def initialize(coordinates = [-1, -1], color = nil)
		@coordinates = coordinates
		@has_moved = false
		@color = color
		@moves_direction_sets = []
		@moves_diagonal_up_right = []
		@moves_right = []
		@moves_diagonal_down_right = []
		@moves_down = []
		@moves_diagonal_down_left = []
		@moves_left = []
		@moves_diagonal_up_left = []
		@moves_up = []
	end
end