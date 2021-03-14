require_relative '../lib/game.rb'

describe Game do
  describe '#choose_player' do
    # not a super great method for testing as coinflip happens inside.
  end

  describe '#set_token' do
    subject(:set_token_game) { described_class.new }

    it 'sets @player1 to x when they are @current_player' do
      set_token_game.current_player = set_token_game.player1
      set_token_game.set_token
      expect(set_token_game.player1.token).to eq('x')
    end
  end

  describe '#change_player' do
    subject(:change_game) { described_class.new }

    it 'swaps current_player from player1 to player2' do
      change_game.current_player = change_game.player1
      change_game.change_player
      expect(change_game.current_player).to eq(change_game.player2)
    end
  end

  describe '#play' do
    # script method
  end

  describe '#display_reset' do
    # script method. test displayable methods.
  end

  describe '#ask_names' do
    # script and gets.chomp
  end

  describe 'explain' do
    # just prints stuff to screen
  end

  describe '#take_turns' do
    # script. it just goes infitely until win is true.
  end

  describe '#player_move(value)' do
    # gosh this is dumb. this just starts another method.
  end

  describe '#check_num(value)' do

  end

  describe '#used?(value)' do

  end

  describe '#update_board(value)' do
    # script
  end

  describe '#check_win' do

  end

  describe '#announce_winner' do
    # scrpit and printing.
  end

  describe '#no_winner' do
    # script. tested methods in displayable.
  end
end
