require_relative 'board.rb'

board = Board.new
board.move([1,1],[1,2])
board.move([1,1],[1,2])
board.move([1,6],[1,5])
board.move([1,5],[1,4])
board.move([1,0],[2,2])
board.move([2,2],[1,4])
board.move([1,4],[2,6])
board.move([2,7],[0,5])
match = board.translate("a5b3")
p match 
puts "First is #{match[1]}, second is #{match[2]}"

