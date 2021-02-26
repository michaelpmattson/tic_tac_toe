# frozen_string_literal: true

# This makes the board. That's all.
class Board
  ROW1 = [0, 1, 2].freeze
  ROW2 = [3, 4, 5].freeze
  ROW3 = [6, 7, 8].freeze
  COLUMN1 = [0, 3, 6].freeze
  COLUMN2 = [1, 4, 7].freeze
  COLUMN3 = [2, 5, 8].freeze
  DIAGONAL_UP = [2, 4, 6].freeze
  DIAGONAL_DOWN = [0, 4, 8].freeze

  attr_accessor :board, :xs, :os, :full

  def initialize(board = [1, 2, 3, 4, 5, 6, 7, 8, 9])
    @board = board
    @xs = []
    @os = []
    @full = false
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '---+---+---'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '---+---+---'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def row1?
    true if ROW1.all? { |i| @xs.include? i } || ROW1.all? { |i| @os.include? i }
  end

  def row2?
    true if ROW2.all? { |i| @xs.include? i } || ROW2.all? { |i| @os.include? i }
  end

  def row3?
    true if ROW3.all? { |i| @xs.include? i } || ROW3.all? { |i| @os.include? i }
  end

  def column1?
    true if COLUMN1.all? { |i| @xs.include? i } || COLUMN1.all? { |i| @os.include? i }
  end

  def column2?
    true if COLUMN2.all? { |i| @xs.include? i } || COLUMN2.all? { |i| @os.include? i }
  end

  def column3?
    true if COLUMN3.all? { |i| @xs.include? i } || COLUMN3.all? { |i| @os.include? i }
  end

  def diagonal_up?
    true if DIAGONAL_UP.all? { |i| @xs.include? i } || DIAGONAL_UP.all? { |i| @os.include? i }
  end

  def diagonal_down?
    true if DIAGONAL_DOWN.all? { |i| @xs.include? i } || DIAGONAL_DOWN.all? { |i| @os.include? i }
  end

  def check_tokens
    check_xs
    check_os
    check_full
  end

  def check_xs
    @board.each_with_index { |value, index| @xs.push(index) if value == 'x' }
  end

  def check_os
    @board.each_with_index { |value, index| @os.push(index) if value == 'o' }
  end

  def row?
    true if row1? || row2? || row3?
  end

  def column?
    true if column1? || column2? || column3?
  end

  def diagonal?
    true if diagonal_up? || diagonal_down?
  end

  def reset_tokens
    xs.clear
    os.clear
  end

  def check_full
    x_and_o = %w[x o]
    count = 0
    @board.each do |i|
      count += 1 if x_and_o.include? i # count up to 9 spaces
      @full = true if count == 9
    end
  end
end

# Stores player name and token.
class Player
  attr_accessor :name, :token

  def initialize(name)
    @name = name
    @token = token
  end
end

# Everything else is here.
class Game
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
    if coinflip.zero?
      @current_player = @player1
      @other_player = @player2
    else
      @current_player = @player2
      @other_player = @player1
    end
  end

  def set_token
    @player1.token = @current_player == @player1 ? 'x' : 'o'
    @player2.token = @current_player == @player2 ? 'x' : 'o'
  end

  def change_player
    @current_player = @current_player == @player1 ? player2 : player1
  end

  def play
    welcome
    ask_names
    choose_player
    set_token
    explain
    take_turns
  end

  def welcome
    puts 'Welcome to tic-tac-toe.'
  end

  def ask_names
    puts 'Player 1: Enter your name.'
    @player1.name = gets.chomp
    puts 'Player 2: Enter your name.'
    @player2.name = gets.chomp
  end

  def explain
    puts
    puts "Hi #{@player1.name} and #{@player2.name}. Let's pick x's and o's randomly, and a player to go first."
    puts
    puts "#{@current_player.name}, you'll be x. #{@other_player.name}, you'll be o. x goes first"
    puts
  end

  def take_turns
    while @win == false
      @my_board.display_board
      puts
      puts "#{@current_player.name}, where would you like to go?"
      player_move(gets.chomp)
      puts
      check_win # check and announce the winnner if there are 3 in a row
      no_winner if @my_board.full == true # check the board for full
      change_player
    end
  end

  def player_move(value)
    check_num(value.to_i)
  end

  def check_num(value)
    spaces = (1..9).to_a # this is an array of the values that are valid
    if spaces.include?(value)
      used?(value) # it's a valid space. check if it's been used already. if not, player goes here (run update_board).
    else
      puts "Sorry, that's not a valid choice. Please try again."
      player_move(gets.chomp)
    end
  end

  def used?(value)
    if @used.include?(value)
      puts "Sorry, that's used already. Please try again."
      player_move(gets.chomp)
    else
      update_board(value) # it's all good. go here.
    end
  end

  def update_board(value)
    @used.push(value) # store the current value in class variable array, used.
    @my_board.board[value - 1] = @current_player.token
  end

  def check_win
    @my_board.check_tokens
    announce_winner if @my_board.row? || @my_board.column? || @my_board.diagonal?
  end

  def announce_winner
    @win = true
    @my_board.display_board
    puts "#{@current_player.name} is the winner!"
  end

  def no_winner
    @win = true
    puts 'No winner this time. Both players are losers!'
  end
end
