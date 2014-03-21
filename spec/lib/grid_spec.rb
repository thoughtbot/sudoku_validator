require 'spec_helper'

describe Grid do
  let(:invalid_complete) { load_sudoku("invalid_complete") }

  context "accessors" do
    before do
      grid = %w[
        1 2 3 4
        5 6 7 8
        9 1 2 3
        4 5 6 7
      ]
      @grid = described_class.new(grid)
    end

    describe "#row" do
      it "fetches the correct row" do
        expect(@grid.row(1)).to eq %w[5 6 7 8]
      end
    end

    describe "#column" do
      it "fetches the correct column" do
        expect(@grid.column(3)).to eq %w[4 8 3 7]
      end
    end

    describe "#subgrid" do
      it "fetches the correct subgrid" do
        expect(@grid.subgrid(0)).to eq %w[1 2 5 6]
        expect(@grid.subgrid(1)).to eq %w[3 4 7 8]
      end
    end
  end
end
