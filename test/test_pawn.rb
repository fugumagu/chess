require 'minitest/autorun'
require_relative '../lib/pawn.rb'

class TestPawnMoves < Minitest::Test

	def setup
		@pawn = Pawn.new
	end

	def teardown
		@pawn = nil
	end

	def test_pawn_moves_set
		assert_equal([[0, 1]], @pawn.moves_set)
	end

	def test_pawn_moves_up
		assert_equal([[0, 1]], @pawn.moves_up)
	end

	def test_pawn_moves_down
		assert_equal([], @pawn.moves_down)
	end

	def test_pawn_moves_left
		assert_equal([], @pawn.moves_left)
	end

	def test_pawn_moves_right
		assert_equal([], @pawn.moves_right)
	end

	def test_pawn_moves_diagonal_up_right
		assert_equal([], @pawn.moves_diagonal_up_right)
	end

	def test_pawn_moves_diagonal_up_left
		assert_equal([], @pawn.moves_diagonal_up_left)
	end

	def test_pawn_moves_diagonal_down_right
		assert_equal([], @pawn.moves_diagonal_down_right)
	end

	def test_pawn_moves_diagonal_down_left
		assert_equal([], @pawn.moves_diagonal_down_left)
	end

end

class TestPawnPosition < Minitest::Test
	def test_pawn_position
		pawn = Pawn.new
		assert_equal([-1, -1], pawn.coordinates)		
	end
end