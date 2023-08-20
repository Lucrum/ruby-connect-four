# frozen_string_literal: true

require_relative '../lib/connect_four'

# rubocop: disable Metrics/BlockLength

describe ConnectFour do
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
