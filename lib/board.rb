require_relative 'knight.rb'
require_relative 'rook.rb'
require_relative 'bishop.rb'
require_relative 'king.rb'
require_relative 'queen.rb'
require_relative 'pawn.rb'
require_relative 'square.rb'

class Board
	attr_accessor :squares, :white_pieces_on_board, :white_pieces_captured, :black_pieces_on_board, :black_pieces_captured,
		:current_player_turn

	def initialize
		board_squares
		@white_pieces_on_board = []
		@white_pieces_captured = []
		@black_pieces_on_board = []
		@black_pieces_captured = []
		@current_player_turn = 'white'
		initial_setup
	end

	def launch!
		welcome
		show_board
		command = nil 
		until command == :quit do 
			command = get_command
		end
		goodbye
	end

	def welcome
		system("clear") or system("cls")
		puts "\n\n***** Welcome to Chess! ***** \n\n\n"
		puts "To move, enter the move in chess format, e.g. e5e6."
	end

	def goodbye
		puts "\n\n**** Goodbye! ****\n\n\n"
	end

	def get_command
		print "Please enter a command >"
		entry = gets.chomp
		route_command(entry)
	end

	def route_command(command)
		case 
		when entry_is_quit?(command)
			return :quit
		when entry_is_move?(command)
			from = command.slice(0,2)
			from = translate(from)

			to = command.slice(2,2)
			to = translate(to)
			system("clear") or system("cls")
			move(from,to)
		end
	end

	def entry_is_quit?(entry)
		if entry.match(/(?:quit|q)/i)
			true 
		else
			false
		end
	end

	def entry_is_move?(entry)
		if entry.match(/[a-h][1-8][a-h][1-8]/)
			return true
		end
	end

	def add_piece(type, color, coordinates)
		case type
		when 'pawn'
			piece = Pawn.new(coordinates, color)
		when 'rook'
			piece = Rook.new(coordinates, color)
		when 'knight'
			piece = Knight.new(coordinates, color)
		when 'bishop'
			piece = Bishop.new(coordinates, color)
		when 'king'
			piece = King.new(coordinates, color)
		when 'queen'
			piece = Queen.new(coordinates, color)
		end

		if color == 'white'
			@white_pieces_on_board << piece
		elsif color == 'black'
			@black_pieces_on_board << piece
		else
			puts "Error in adding pieces"
		end

		add_piece_to_square(piece, coordinates)
		return
	end

	def piece_possible_moves(square)
		piece = square.has_piece
		possible_moves = []

		#go through each direction_set in moves_direction_sets (up, down, left, right, up right, up left, down right, down left)
		piece.moves_direction_sets.each do |direction_set|
			#  up moves: if first up matches a square that is not occupied, add first up to possible moves
			direction_set.each do |direction_move|
				proposed_move = proposed_move(square.coordinates, direction_move)

				#go to the next up move if the piece is not on the board
				break unless is_on_the_board(proposed_move)

				#get the proposed square from the squares array
				proposed_square = @squares[square_at(proposed_move)]

				#if the proposed square is empty, add up-move to possible moves and go to the next move
				if proposed_square.has_piece.nil?
					possible_moves << proposed_move
					next				
				#go to the next up move if the proposed square has a piece of the same color as the moving piece
				elsif proposed_square.has_piece.color == piece.color
					break

				#add proposed move to possible moves if the proposed square has an opponent's piece
				elsif proposed_square.has_piece.color != piece.color
					possible_moves << proposed_move
					break
				else
					puts "error in piece_possible_moves"
				end
			end
			#next, go to next direction_set
		end
		return possible_moves
	end

	def board_squares
		squares = []
		
		for y in 0..7
			for x in 0..7
				square = Square.new(x,y)
				squares << square
			end
		end

		@squares = squares
	end

	def add_piece_to_square(piece, coordinates)
		square_index = square_at(coordinates)
		square = @squares[square_index]
		square.has_piece = piece
		piece.coordinates = coordinates
		return
	end

	def remove_piece_from_square(coordinates)
		square_index = square_at(coordinates)
		square = @squares[square_index]
		piece = square.has_piece
		square.has_piece = nil
		piece.coordinates = nil
		return		
	end

	def square_at(coordinates)
		x = coordinates[0]
		y = coordinates[1]
		square_index = x + 8 * y
		return square_index
	end

	def square_index_to_coordinates(square_index)
		x = square_index % 8
		y = (square_index / 8).floor
		coordinates = [x, y]
		return coordinates
	end

	def is_on_the_board(coordinates)
		x = coordinates[0]
		y = coordinates[1]
		if x >= 0 && x <= 7 && y >= 0 && y <= 7
			return true
		else
			return false
		end
	end

	def proposed_move(from, move)
		new_x = from[0] + move[0]
		new_y = from[1] + move[1]
		return [new_x, new_y]
	end

	def initial_setup
		for r in 0..1 do
			if r == 0
				color = 'white'
			else
				color = 'black'
			end

			for i in 0..7 do 
				add_piece('pawn', color, [i, 5 * r + 1])
			end

			for i in 0..1 do 
				add_piece('rook', color, [7 * i, 7 * r])
				add_piece('knight', color, [5 * i + 1, 7 * r])
				add_piece('bishop', color, [3 * i + 2, 7 * r])
				add_piece('queen', color, [3, 7 * r])
				add_piece('king', color, [4, 7 * r])
			end
		end
	end

	def show_all_squares
		@squares.each do |square|
			if square.has_piece.nil?
				color = nil
				piece = "nothing"
			else
				color = square.has_piece.color
				piece = square.has_piece.class.name
			end

			puts "Square #{square.coordinates} contains a #{color} #{piece}"
		end
	end

	def ok_to_move_piece?(from, to)
		starting_square = @squares[square_at(from)]
		
		return false if starting_square.has_piece.nil?

		possible_moves = piece_possible_moves(starting_square)
		if possible_moves.include?(to)
			return true
		else
			return false
		end
	end

	def translate(input)
		input = input.split("")
		output = []
		output << input[0].ord - 97
		output << input[1].to_i - 1
		return output
	end

	def move(from, to)
		puts ''
		puts '****************************'
		puts ''
		# puts "Attempting to move from #{from} to #{to}"

		if ok_to_move_piece?(from, to)

			starting_square = @squares[square_at(from)]
			ending_square = @squares[square_at(to)]


			moving_piece = starting_square.has_piece
			moving_piece.has_moved = true

			unless ending_square.has_piece.nil?
				captured_piece = ending_square.has_piece
				if captured_piece.color == 'white'
					@white_pieces_on_board.delete(captured_piece)
					@white_pieces_captured << captured_piece
				elsif captured_piece.color == 'black'
					@black_pieces_on_board.delete(captured_piece)
					@black_pieces_captured << captured_piece
				end

				puts "#{moving_piece.class.name} captures #{captured_piece.class.name}!"
			end

			remove_piece_from_square(from)
			add_piece_to_square(moving_piece, to)
		else
			puts "Not a valid move" #from #{from} to #{to}"
		end
		show_board
		puts ''
		# is_in_check('white')
		# is_in_check('black')
	end

	def piece_symbol(piece)
		return piece.unicode.encode('utf-8')
	end

	def show_board
		for y in 0..7
			puts ""
			print "#{8 - y} "
			for x in 0..7
				square = @squares[square_at([x, 7 - y])]
				if square.has_piece.nil?
					piece = ' '
				else
					piece = piece_symbol(square.has_piece)
				end
					print "[#{piece} ]"
			end
		end
		puts ''
		puts ('   a   b   c   d   e   f   g   h')
	end

	def is_in_check(color)
		case color
		when 'white'
			player_pieces = @black_pieces_on_board
			opponent_pieces = @white_pieces_on_board
			opponent = 'Black'
		when 'black'
			player_pieces = @white_pieces_on_board
			opponent_pieces = @black_pieces_on_board
			opponent = 'White'
		end

		#get location of enemy king from enemy pieces array
		opponent_king = opponent_pieces.find{ |opponent_piece| opponent_piece.class.name == 'King' }

		#for each of the player's pieces
			#get possible moves
			#if possible moves includes location of opponent's king
				#then check
			#end
		#end
			check = false
			player_pieces.each do |player_piece|
				square = @squares[square_at(player_piece.coordinates)]
				piece_possible_moves = piece_possible_moves(square)
				if piece_possible_moves.include?(opponent_king.coordinates)
					check = true
					break	
				end
			end

		puts "#{color} is in check" if check == true
		return check
	end

	def will_result_in_check(color, from, to)
		hypothetical_squares = @squares 


	end

end