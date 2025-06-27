# frozen_string_literal: true

require_relative '../lib/game'

describe Pawn, '.legal_moves' do
  context 'when starting' do
    it 'has two-square move' do
      g = Game.new
      expect(described_class.legal_moves([6, 3], g)).to eq(%w[d3 d4])
    end
  end

  context 'when able to capture' do
    it 'has capture' do
      g = Game.new
      g.move 'd4'
      g.move 'e5'
      expect(described_class.legal_moves([4, 3], g)).to eq(%w[d5 dxe5])
    end
  end

  context 'when able to en passant' do
    it 'has en passant' do
      g = Game.new
      g.move 'd4'
      g.move 'e5'
      g.move 'dxe5'
      g.move 'f5'
      expect(described_class.legal_moves([3, 4], g)).to eq(%w[e6 exf6])
    end
  end

  context 'when moven but no captures available' do
    it 'has single move' do
      g = Game.new
      g.move 'd4'
      g.move 'a5'
      expect(described_class.legal_moves([4, 3], g)).to eq(['d5'])
    end
  end

  context 'when unable to move' do
    it 'is empty set' do
      g = Game.new
      g.move 'd4'
      g.move 'd5'
      expect(described_class.legal_moves([4, 3], g)).to eq([])
    end
  end

  context 'when able to capture and/or promote' do
    it 'has moves with promotion' do
      # 1. d4 a5 2. d5 a4 3. d6 b5 4. dxc7 Ba6
      g = Game.new
      g.move 'd4'
      g.move 'a5'
      g.move 'd5'
      g.move 'a4'
      g.move 'd6'
      g.move 'b5'
      g.move 'dxc7'
      g.move 'Ba6'
      expect(described_class.legal_moves([1, 2], g)).to eq(%w[c8Q cxb8Q cxd8Q c8B cxb8B cxd8B c8N cxb8N cxd8N c8R cxb8R cxd8R])
    end
  end
end
