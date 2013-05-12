require_relative '../../lib/inverted_index/index_calculator'
require_relative '../../lib/inverted_index/document'

describe InvertedIndex::IndexCalculator do
  let(:terms) { %w(ala ela kota ma maja wszyscy) }
  let(:documents) do
    [
      InvertedIndex::Document.new('Ala ma kota.', 0),
      InvertedIndex::Document.new('Ela ma kota.', 1),
      InvertedIndex::Document.new('Wszyscy maja kota.', 2)
    ]
  end
  let(:results) { InvertedIndex::IndexCalculator.calculate_positions(terms, documents) }

  it 'calculates inverted index positions' do
    results.should eq ({
      'ala' => [[0, 0]],
      'ela' => [[1, 0]],
      'kota' => [[0, 2], [1, 2], [2, 2]],
      'ma' => [[0, 1], [1, 1]],
      'maja' => [[2, 1]],
      'wszyscy' => [[2, 0]]
    })
  end

end
