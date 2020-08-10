require_relative '../lib/Players.rb'

class Logic
  attr_reader :board
  WINNING_MOVES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze
  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @player1_array = Players.player1_array
    @player2_array = Players.player2_array
  end

  def update(move, current_player)
    return false if @board[move - 1] == 'X' || @board[move - 1] == 'O'

    @board[move - 1] = current_player[0]
    if current_player[0] == 'X'
      @player1_array.push(move)
      check_move(@player1_array)
    elsif current_player[0] == 'O'
      @player2_array.push(move)
      check_move(@player2_array)
    end
  end

  def check_move(array)
    if winning_move?(array)
      reinstate_logic
      'WIN'
    elsif draw?(array)
      reinstate_logic
      'DRAW'
    end
  end

  def winning_move?(array)
    WINNING_MOVES.length.times do |i|
      return true if WINNING_MOVES[i].all? { |j| array.include?(j) }
    end
    false
  end

  def draw?(_array)
    @board.none?(Integer)
  end

  def reinstate_logic
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @player1_array = []
    @player2_array = []
  end
end
