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
        new_state = [nil, nil, nil, nil, nil, nil, 'X']
        old_board = board_play.instance_variable_get(:@state)
        expect { board_play.play_move(6, 'X') }.to change { old_board[0] }.to(new_state)
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
        expect(board_victory_row.victory_row?).to eq('O')
      end
    end
  end

  describe '#victory_column?' do
    winning_game_column = [[nil, nil, 'O', 'O', 'O', nil, nil],
                           [nil, nil, 'X', 'X', 'O', nil, nil],
                           [nil, nil, 'X', nil, nil, nil, nil],
                           [nil, nil, 'X', nil, nil, nil, nil],
                           [nil, nil, 'X', nil, nil, nil, nil],
                           [nil, nil, nil, nil, nil, nil, nil]]
    subject(:board_victory_column) { described_class.new(winning_game_column) }
    context 'when there are four pieces in a column' do
      it 'declares a victory for that player' do
        expect(board_victory_column.victory_column?).to eq('X')
      end
    end
  end
end
