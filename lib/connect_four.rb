# frozen_string_literal: true

# main game class
class ConnectFour
  def initialize
    @board = []
    @player_one_token = nil
    @player_two_token = nil
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
