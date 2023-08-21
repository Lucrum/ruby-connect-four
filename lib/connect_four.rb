# frozen_string_literal: true

# main game class
class ConnectFour
  def initialize(player_one = nil, player_two = nil, board = Board.new)
    @board = board
    @player_one_token = player_one
    @player_two_token = player_two
  end

  def game_loop
    loop do

      break if @board.victory?
    end
  end

  def player_turn(player, player_symbol)
    loop do
      puts "Player #{player}, your move: "
      user_input = gets.chomp.to_i
      break if @board.play_move(user_input, player_symbol)
    end
  end

  def player_tokens
    puts 'Player one token: '
    loop do
      @player_one_token = verify_token(gets.chomp)
      break if @player_one_token

      puts 'Bad token! Please enter a single character: '
    end

    puts 'Player two token: '
    loop do
      @player_two_token = verify_token(gets.chomp)
      break if @player_two_token

      puts 'Bad token! Please enter a single character: '
    end
  end

  def verify_token(token)
    token.match(/^.{1}$|^[\u2600-\u26FF]{1}$/) ? token : nil
  end
end
