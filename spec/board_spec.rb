# frozen_string_literal: true

require_relative '../lib/connect_four'
require_relative '../lib/board'

# rubocop: disable Metrics/BlockLength

describe Board do
  describe '#valid_move?' do
    board_state = [[nil, nil, 'X', nil, nil, nil, nil]] * 6
    subject(:board_move_validation) { described_class.new(board_state) }
    context 'it is given a valid move on empty column' do
      it 'accepts the move' do
        expect(board_move_validation.valid_move?(1)).to be true
      end
    end

    context 'when given a move out of bounds' do
      it 'rejects the move' do
        expect(board_move_validation.valid_move?(9)).to be false
      end
    end

    context 'when given a move on a full column' do
      it 'rejects the move' do
        expect(board_move_validation.valid_move?(2)).to be false
      end
    end
  end

  describe '#play_move' do
    subject(:board_play) { described_class.new }

    context 'when the board is empty' do
      it 'plays a valid move' do
        new_state = [[nil, nil, nil, nil, nil, nil, 'X'],
                     [nil, nil, nil, nil, nil, nil, nil],
                     [nil, nil, nil, nil, nil, nil, nil],
                     [nil, nil, nil, nil, nil, nil, nil],
                     [nil, nil, nil, nil, nil, nil, nil],
                     [nil, nil, nil, nil, nil, nil, nil]]
        old_board = board_play.instance_variable_get(:@state)
        return_coords = nil
        expect { return_coords = board_play.play_move(6, 'X') }.to change { old_board }.to(new_state)
        expect(return_coords).to eq([6, 0])
      end
    end

    context 'when the board has pieces in it' do
      game_state = [[nil, nil, 'X', 'O', 'O', nil, nil],
                    [nil, nil, 'X', 'X', 'O', nil, nil],
                    [nil, nil, 'O', nil, nil, nil, nil],
                    [nil, nil, 'X', nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil],
                    [nil, nil, nil, nil, nil, nil, nil]]
      subject(:board_play_existing) { described_class.new(game_state) }

      it 'stacks pieces' do
        new_state = [nil, nil, nil, nil, 'O', nil, nil]
        old_board = board_play.instance_variable_get(:@state)
        expect { board_play.play_move(4, 'O') }.to change { old_board[2] }.to(new_state)
      end
    end
  end

  describe '#victory_row?' do
    winning_game_row = [[nil, 'O', 'O', 'O', 'O', nil, nil],
                        [nil, nil, 'X', 'X', 'O', nil, nil],
                        [nil, nil, 'X', nil, nil, nil, nil],
                        [nil, nil, 'X', nil, nil, nil, nil],
                        [nil, nil, nil, nil, nil, nil, nil],
                        [nil, nil, nil, nil, nil, nil, nil]]
    subject(:board_victory_row) { described_class.new(winning_game_row) }
    context 'when there are four pieces in a row' do
      it 'declares a victory for that player' do
        expect(board_victory_row.victory_row?(0)).to eq('O')
      end
    end

    subject(:board_no_victory) { described_class.new }
    context 'when there are no winning pieces' do
      it 'returns nil' do
        expect(board_no_victory.victory_row?(5)).to be nil
      end
    end
  end

  describe '#victory_column?' do
    winning_game_column = [[nil, nil, 'O', 'O', 'O', 'X', nil],
                           [nil, nil, 'X', 'X', 'O', nil, nil],
                           [nil, nil, 'X', nil, nil, nil, nil],
                           [nil, nil, 'X', nil, nil, nil, nil],
                           [nil, nil, 'X', nil, nil, nil, nil],
                           [nil, nil, nil, nil, nil, nil, nil]]
    subject(:board_victory_column) { described_class.new(winning_game_column) }
    context 'when there are four pieces in a column' do
      it 'declares a victory for that player' do
        expect(board_victory_column.victory_column?(2)).to eq('X')
      end
    end

    losing_game_column = [[nil, nil, nil, 'X', nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil],
                          [nil, nil, nil, nil, nil, nil, nil]]
    subject(:board_no_victory_column) { described_class.new(losing_game_column) }

    context 'when there are not four pieces in a column' do
      it 'returns nil' do
        expect(board_no_victory_column.victory_column?(3)).to be nil
      end
    end
  end

  describe '#victory_diagonal?' do
    context 'when there is a winning diagonal' do
      winning_game_diagonal = [['X', 'X', 'O', 'O', 'O', nil, nil],
                               ['X', 'O', 'X', 'X', 'O', nil, nil],
                               ['O', 'O', 'X', nil, nil, nil, nil],
                               ['O', 'X', 'X', nil, nil, nil, nil],
                               ['X', nil, 'O', nil, nil, nil, nil],
                               [nil, nil, nil, nil, nil, nil, nil]]
      subject(:board_victory_diagonal) { described_class.new(winning_game_diagonal) }
      it 'declares the winner when the diagonal crosses down' do
        expect(board_victory_diagonal.victory_diagonal?(2, 2)).to eq('X')
      end

      winning_game_diagonal_down = [['X', 'O', 'O', 'X', 'O', nil, nil],
                                    ['X', 'O', 'O', 'X', 'O', nil, nil],
                                    ['O', 'O', 'X', 'O', 'X', nil, nil],
                                    ['O', nil, 'X', nil, 'O', nil, nil],
                                    [nil, nil, 'O', nil, nil, nil, nil],
                                    [nil, nil, nil, nil, nil, nil, nil]]
      subject(:board_victory_diagonal_down) { described_class.new(winning_game_diagonal_down) }
      it 'declares the winner when the diagonal crosses up' do
        expect(board_victory_diagonal_down.victory_diagonal?(3, 2)).to eq('O')
      end

      it 'does not declare the winner on a different diagonal' do
        expect(board_victory_diagonal_down.victory_diagonal?(2, 3)).to be nil
      end
    end

    context 'when there is no winning diagonal' do
      subject(:board_no_victory) { described_class.new }
      it 'returns nil' do
        expect(board_no_victory.victory_diagonal?(4, 2)).to be nil
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
