class Square
	attr_accessor :coordinates, :has_piece, :color
	
	def initialize(x, y)
		@coordinates = [x, y]
		@has_piece = nil

		if (x + y) % 2 == 0
			@color = 'black'
		else
			@color = 'white'
		end
	end
end