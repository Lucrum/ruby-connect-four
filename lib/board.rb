# frozen_string_literal: true

# board for connect four
class Board
  def initialize(state = [[nil] * 7] * 6)
    @state = state
  end

  def victory?
    true
  end

  def play_move(column, player_symbol)
    row = 0
    while row < 6
      if @state[row][column].nil?
        @state[row][column] = player_symbol
        break
      end
      row += 1
    end
  end

  def valid_move?(move)
    # out of bounds
    return false if move.negative? || move > 6

    # column full
    @state[5][move].nil?
  end
end
