# frozen_string_literal: true

# board for connect four
class Board
  def initialize(initial_state = Array.new(6) { Array.new(7) })
    @state = initial_state
  end

  def play_move(column, player_symbol)
    row = 0
    while row < @state.length
      if @state[row][column].nil?
        @state[row][column] = player_symbol
        return [column, row]
      end
      row += 1
    end
  end

  def valid_move?(move)
    # out of bounds
    return false if move.negative? || move > 6

    # column full
    @state[@state.length - 1][move].nil?
  end

  def victory?(column, row)
    row_victor = victory_row?(row)
    return row_victor if row_victor

    column_victor = victory_column?(column)
    return column_victor if column_victor

    diagonal_victor = victory_diagonal?(column, row)
    return diagonal_victor if diagonal_victor
  end

  def victory_row?(row)
    array_cons(@state[row])
  end

  def victory_column?(column)
    array_cons(@state.transpose[column])
  end

  def victory_diagonal?(column, row)
    diag_left = array_cons(generate_left_diagonal(column, row))
    return diag_left if diag_left

    array_cons(generate_right_diagonal(column, row))
  end

  def pretty_print
    @state.reverse.each do |row|
      row.each_with_index do |elem, index|
        output = elem.nil? ? ' ' : elem
        print output
        print '|' unless index == row.length - 1
      end
      print "\n-+-+-+-+-+-+-\n"
    end
  end

  private

  # returns the winning symbol if the array has any 4 consecutive pieces
  def array_cons(arr)
    res = arr.each_cons(4).select do |w, x, y, z|
      w == x && x == y && y == z
    end

    res.any? ? res[0][0] : nil
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize

  # left -> right, upwards on upside down board
  def generate_left_diagonal(pos_x, pos_y)
    res = []
    # generate 'bottom' side of diagonal
    temp_x = pos_x + 1
    temp_y = pos_y - 1
    until temp_x >= @state[0].length || temp_y.negative?
      res.unshift(@state[temp_y][temp_x])
      temp_x += 1
      temp_y -= 1
    end

    res.append(@state[pos_y][pos_x])

    temp_x = pos_x - 1
    temp_y = pos_y + 1

    until temp_x.negative? || temp_y >= @state.length
      res.append(@state[temp_y][temp_x])
      temp_x -= 1
      temp_y += 1
    end
    res
  end

  # left -> right, downwards on upside down board
  def generate_right_diagonal(pos_x, pos_y)
    res = []
    # generate 'bottom' side of diagonal
    temp_x = pos_x - 1
    temp_y = pos_y - 1
    until temp_x.negative? || temp_y.negative?
      res.unshift(@state[temp_y][temp_x])
      temp_x -= 1
      temp_y -= 1
    end

    res.append(@state[pos_y][pos_x])

    temp_x = pos_x + 1
    temp_y = pos_y + 1

    until temp_x >= @state[0].length || temp_y >= @state.length
      res.append(@state[temp_y][temp_x])
      temp_x += 1
      temp_y += 1
    end
    res
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
end
