#### Chess ####
#
# Launch this Ruby file from the command line 
# to get started.
#

APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'board'

board = Board.new
board.launch!