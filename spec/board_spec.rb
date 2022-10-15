require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  it 'has a board attribute' do
    expect(board).to have_attributes(board: Array)
  end

  it 'has 6 rows' do
    expect(board.board.size).to eq(6)
  end

  it 'has 7 files' do
    expect(board.board[0].size).to eq(7)
  end
end
