# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'displayable.rb'
require 'pry'

# Everything else is here.
class Game
  include Displayable

  attr_accessor :my_board, :player1, :player2, :current_player, :other_player, :win, :used

  def initialize
    @my_board = Board.new
    @player1 = Player.new('player1')
    @player2 = Player.new('player2')
    @current_player = current_player
    @other_player = other_player
    @win = false
    @used = []
  end

  def choose_player
    coinflip = rand(2)
    @current_player = coinflip.zero? ? @player1 : @player2
    @other_player = coinflip.zero? ? @player2 : @player1
  end

  def set_token
    @player1.token = @current_player == @player1 ? 'x' : 'o'
    @player2.token = @current_player == @player2 ? 'x' : 'o'
  end

  def change_player
    @current_player = @current_player == @player1 ? player2 : player1
  end

  def play
    display_reset
    display(tell[:welcome])
    ask_names
    choose_player
    set_token
    explain
    take_turns
  end

  def display_reset
    display_clear
    display(header)
    display(@my_board.display_board)
  end

  def ask_names
    display('Player 1: Enter your name.')
    @player1.name = gets.chomp
    display('Player 2: Enter your name.')
    @player2.name = gets.chomp
  end

  def explain
    display_reset
    display("Hi #{@player1.name} and #{@player2.name}. Let's pick x's and o's randomly, and a player to go first.")
    display("#{@current_player.name}, you'll be x. #{@other_player.name}, you'll be o. x goes first")
  end

  def take_turns
    while @win == false
      display("#{@current_player.name}, where would you like to go?")
      player_move(gets.chomp)
      puts
      check_win # check and announce the winnner if there are 3 in a row
      no_winner if @my_board.full == true # check the board for full
      change_player
      display_reset
    end
  end

  def player_move(value)
    check_num(value.to_i)
  end

  def check_num(value)
    spaces = (1..9).to_a # this is an array of the values that are valid
    if spaces.include?(value)
      # it's a valid space. check if it's been used already. if not, player goes here (run update_board).
      used?(value)
    else
      display(tell[:invalid])
      player_move(gets.chomp)
    end
  end

  def used?(value)
    if @used.include?(value)
      display(tell[:invalid])
      player_move(gets.chomp)
    else
      update_board(value) # it's all good. go here.
    end
  end

  def update_board(value)
    @used.push(value) # store the current value in class variable array, used.
    @my_board.add(value, @current_player.token)
  end

  def check_win
    @my_board.check_tokens
    announce_winner if @my_board.three_in_row?
  end

  def announce_winner
    @win = true
    display_reset
    display("#{@current_player.name} is the winner!")
    exit
  end

  def no_winner
    @win = true
    display_reset
    display(tell[:tie])
    exit
  end
end
