# frozen_string_literal: true

# board for connect four
class Board
  def initialize(state = [[nil] * 7] * 6)
    @state = state
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

  def victory_row?
    @state.each do |row|
      res = check_array_cons(row)
      return res if res
    end
  end

  def victory_column?
    @state.transpose.each do |column_row|
      res = check_array_cons(column_row)
      return res if res
    end
  end

  private

  def check_array_cons(arr)
    res = arr.each_cons(4).select do |w, x, y, z|
      w == x && x == y && y == z
    end

    res.any? ? res[0][0] : nil
  end
end
