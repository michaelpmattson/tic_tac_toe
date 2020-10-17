class Board
  attr_accessor :board

  def initialize(board = [1,2,3,4,5,6,7,8,9])
    @board = board;
  end

  def displayBoard
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "---+---+---"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "---+---+---"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
end


class Player
  attr_accessor :name, :token

  def initialize(name)
    @name = name
    @token = token
  end
end


class Game
  @@player1 = ''
  @@player2 = ''
  @@myBoard = Board.new()
  @@win = false
  @@currentPlayer
  @@otherPlayer
  @@used = []

  def initialize
    puts "Welcome to tic-tac-toe."
    getNames
    puts
    puts "Hi #{@@player1.name} and #{@@player2.name}."
    puts
    puts "Let's pick x's and o's randomly, and a player to go first."
    choosePlayer
    puts
    puts "#{@@currentPlayer.name}, you'll be x. #{@@otherPlayer.name}, you'll be o."
    puts "x goes first."
    puts
  end

  def getNames
    puts "Player 1: Enter your name."
    @@player1 = Player.new(gets.chomp)
    puts "Player 2: Enter your name."
    @@player2 = Player.new(gets.chomp)
  end

  def choosePlayer
    coinflip = rand(2)
    if coinflip == 0
      @@currentPlayer = @@player1
      @@player1.token = 'x'
      @@otherPlayer = @@player2
      @@player2.token = 'o'
    else
      @@currentPlayer = @@player2
      @@player2.token = 'x'
      @@otherPlayer = @@player1
      @@player1.token = 'o'
    end
  end

  def changePlayer
    if @@currentPlayer == @@player1
      @@currentPlayer = @@player2
    else
      @@currentPlayer = @@player1
    end
  end

  def play()

    @@myBoard.displayBoard()
    puts
    while @@win == false
      
      puts "#{@@currentPlayer.name}, where would you like to go?"
      puts
      playerMove(gets.chomp)
      puts
      @@myBoard.displayBoard()
      puts

      checkWin
      
      changePlayer
    end
      
  end

  def playerMove(value)
    checkNum(value.to_i)
  end

  def checkNum(value)
    spaces = (1..9).to_a #this is an array of the values that are valid
    if spaces.include?(value)
      used?(value) #it's a valid space. check whether it's been used already. if not, player goes here (run updateBoard).
    else
      puts "Sorry, that's not a valid choice. Please try again." #can't use it. pick again
      playerMove(gets.chomp)
    end
  end

  def used?(value)
    if @@used.include?(value)
      puts "Sorry, that's used already. Please try again." #can't use it. pick again.
      playerMove(gets.chomp)
    else
      updateBoard(value) #it's all good. go here.
    end
  end

  def updateBoard(value)
    @@used.push(value) #store the current value in class variable array, used.
    @@myBoard.board[value-1] = @@currentPlayer.token
  end

  def checkWin()
    # if there are 3 in a row, announceWinner
    announceWinner if @@myBoard.board[0] == @@myBoard.board[1] && @@myBoard.board[1] == @@myBoard.board[2]
    announceWinner if @@myBoard.board[3] == @@myBoard.board[4] && @@myBoard.board[4] == @@myBoard.board[5]
    announceWinner if @@myBoard.board[6] == @@myBoard.board[7] && @@myBoard.board[7] == @@myBoard.board[8]
    # column
    announceWinner if @@myBoard.board[0] == @@myBoard.board[3] && @@myBoard.board[3] == @@myBoard.board[6]
    announceWinner if @@myBoard.board[1] == @@myBoard.board[4] && @@myBoard.board[4] == @@myBoard.board[7]
    announceWinner if @@myBoard.board[2] == @@myBoard.board[5] && @@myBoard.board[5] == @@myBoard.board[8]
    # diagonal
    announceWinner if @@myBoard.board[0] == @@myBoard.board[4] && @@myBoard.board[4] == @@myBoard.board[8]
    announceWinner if @@myBoard.board[6] == @@myBoard.board[4] && @@myBoard.board[4] == @@myBoard.board[2]

    checkFull if @@win == false
  end

  def announceWinner
    @@win = true
    puts "#{@@currentPlayer.name} is the winner!"
  end

  def checkFull
    count = 0
    @@myBoard.board.each do |i|
      count += 1 if i == 'x' || i == 'o' #count up to 9 spaces
      noWinner if count == 9
    end
  end

  def noWinner
    @@win = true
    puts "No winner this time. Both players are losers!"
  end
end


myGame = Game.new()
myGame.play()