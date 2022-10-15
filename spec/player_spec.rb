require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('⚫') }

  it 'has a color attribute' do
    expect(player).to have_attributes(piece: String)
  end

  context 'when passed ⚫ as an argument' do
    it 'sets ⚫ as piece' do
      expect(player.instance_variable_get('@piece')).to eq('⚫')
    end
  end

  context 'when passed ⚪ as an argument' do
    let(:player_white) { described_class.new('⚪') }
    it 'sets ⚪ as piece' do
      expect(player_white.instance_variable_get('@piece')).to eq('⚪')
    end
  end
end
