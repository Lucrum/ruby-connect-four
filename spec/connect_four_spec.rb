# frozen_string_literal: true

require_relative '../lib/connect_four'
require_relative '../lib/board'

# rubocop: disable Metrics/BlockLength

describe ConnectFour do
  describe '#game_loop' do
    # scripting method, not necessary to test
  end

  describe '#player_turn' do
    let(:board) { instance_double(Board) }
    subject(:game_input) { described_class.new('X', 'Y', board) }

    context "it is player 1's turn" do
      before do
        valid_column = 4
        player_symbol = 'X'
        allow(board).to receive(:play_move).with(valid_column, player_symbol).and_return([4, 0])
        allow(game_input).to receive(:gets).and_return(valid_column.to_s)
      end

      it 'plays the move' do
        player = 1
        player_symbol = 'X'
        turn_request = "Player #{player}, your move: "
        expect(game_input).to receive(:puts).with(turn_request)
        expect(board).to receive(:play_move)
        game_input.player_turn(player, player_symbol)
      end
    end
  end

  describe '#player_tokens' do
    subject(:game_tokens) { described_class.new }

    context 'when inputting two valid tokens' do
      before do
        valid_token_one = '@'
        valid_token_two = 'X'
        allow(game_tokens).to receive(:gets).and_return(valid_token_one, valid_token_two)
      end

      it 'accepts two valid tokens' do
        message_player_one = 'Player one token: '
        message_player_two = 'Player two token: '
        expect(game_tokens).to receive(:puts).with(message_player_one)
        expect(game_tokens).to receive(:puts).with(message_player_two)
        game_tokens.player_tokens
      end
    end

    context 'when inputting an invalid token, then valid ones' do
      before do
        invalid_token = '!!'
        valid_token_one = '♡'
        valid_token_two = 'X'
        allow(game_tokens).to receive(:gets).and_return(invalid_token, valid_token_one, valid_token_two)
      end

      it 'rejects the invalid, then accepts both valid tokens' do
        message_player_one = 'Player one token: '
        message_player_two = 'Player two token: '
        error_message = 'Bad token! Please enter a single character: '
        expect(game_tokens).to receive(:puts).with(error_message)
        expect(game_tokens).to receive(:puts).with(message_player_one)
        expect(game_tokens).to receive(:puts).with(message_player_two)
        game_tokens.player_tokens
      end
    end
  end

  describe '#verify_token' do
    subject(:game_verify_token) { described_class.new }

    it 'returns a valid token' do
      valid_token = '@'
      expect(game_verify_token.verify_token(valid_token)).to eq(valid_token)
    end

    it 'returns nil on an invalid token' do
      invalid_token = 'hello'
      expect(game_verify_token.verify_token(invalid_token)).to be_nil
    end
  end
end

# rubocop: enable Metrics/BlockLength
