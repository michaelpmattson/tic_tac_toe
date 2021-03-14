require_relative '../lib/board'

describe Board do
  describe "#add" do
    subject(:default_board) { described_class.new }

    context 'when space selected is 1 and token is x' do

      it 'changes value 1 on board to x' do
        index = default_board.board.index(1)
        default_board.add(1, 'x')
        expect(default_board.board[index]).to eq('x')
      end

      it "doesn't change value 2" do
        index = default_board.board.index(2)
        default_board.add(1, 'x')
        expect(default_board.board[index]).to eq(2)
      end
    end

    context 'when token is o' do
      it 'changes value on board to o' do
        index = default_board.board.index(2)
        default_board.add(1, 'o')
        expect(default_board.board[index]).to eq(2)
      end

      it "doesn't change value 2" do
        index = default_board.board.index(2)
        default_board.add(1, 'o')
        expect(default_board.board[index]).to eq(2)
      end
    end
  end

  describe "#display_board" do
    # nothing to test. it's just an array that stores class variables.
  end

  describe "#check_tokens" do
    # nothing to test. it's a script method.
  end

  describe "#store_xs" do
    subject(:x_board) { described_class.new(['x',2,3,'x',5,6,7,'x',9]) }

    it 'checks and adds each index # to array for xs' do
      x_board.store_xs
      expect(x_board.xs).to eq([0,3,7])
    end
  end

  describe "#store_os" do
    subject(:o_board) { described_class.new(['x',2,'o','x',5,'o',7,'x',9]) }

    it 'checks and adds each index # to array for xs' do
      o_board.store_os
      expect(o_board.os).to eq([2,5])
    end
  end

  describe "#check_full" do
    subject(:full_board) { described_class.new(['o','o','x','x','x','o','x','o','x']) }

    it 'updates @full to true if board is full' do
      full_board.check_full
      expect(full_board.full).to be(true)
    end

    subject(:not_full_board) { described_class.new(['o','o',2,'x','x','o','x','o','x']) }

    it 'does not update @full to true if board is not full' do
      not_full_board.check_full
      expect(not_full_board.full).to_not be(true)
    end
  end

  describe "#three_in_row?" do
    subject(:x_row) { described_class.new(['x','x','x',4,5,6,7,8,9]) }

    it 'returns true if there is a matching row in the xs array' do
      x_row.store_xs
      expect(x_row.three_in_row?).to be(true)
    end

    subject(:o_diag) { described_class.new([1,2,'o',4,'o',6,'o',8,9]) }

    it 'returns true if there is a matching diagonal in the os array' do
      o_diag.store_os
      expect(o_diag.three_in_row?).to be(true)
    end
  end
end
