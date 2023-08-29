# frozen_string_literal: true

require_relative 'board'

# main game class
class ConnectFour
  def initialize(player_one = nil, player_two = nil, board = Board.new)
    @board = board
    @player_one_token = player_one
    @player_two_token = player_two

    # false for player one, true for player two
    @player = false
  end

  def setup
    player_tokens
    game_loop
  end

  def game_loop
    loop do
      curr_player = @player ? ['two', @player_two_token] : ['one', @player_one_token]
      @player = !@player
      @board.pretty_print
      response = player_turn(curr_player[0], curr_player[1])
      break if @board.victory?(response[0], response[1])
    end
    print 'exiting'
  end

  def player_turn(player, player_symbol)
    loop do
      print "Player #{player}, your move: "
      user_input = gets.chomp.to_i
      response = @board.play_move(user_input, player_symbol) if @board.valid_move?(user_input)
      return response if response
    end
  end

  def player_tokens
    print 'Player one token: '
    loop do
      @player_one_token = verify_token(gets.chomp)
      break if @player_one_token

      print 'Bad token! Please enter a single character: '
    end

    print 'Player two token: '
    loop do
      @player_two_token = verify_token(gets.chomp)
      break if @player_two_token

      print 'Bad token! Please enter a single character: '
    end
  end

  def verify_token(token)
    token.match(/^.{1}$|^[\u2600-\u26FF]{1}$/) ? token : nil
  end
end

game = ConnectFour.new
game.setup
