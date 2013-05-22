require_relative '../../lib/inverted_index/document'

describe InvertedIndex::Document do
  let(:document) { InvertedIndex::Document.new('Ala ma kota', 0) }

  describe '#terms' do
    it 'return document terms' do
      document.terms.should eq %w(ala ma kota)
    end

    it 'skips non words characters' do
      document = InvertedIndex::Document.new('Hej, jak sie masz?', 0)
      document.terms.should eq %w(hej jak sie masz)
    end
  end

  describe '#term_position' do
    context 'document contains term' do
      it 'returns position of term in document' do
        document.term_position('ala').should eq [0]
        document.term_position('ma').should eq [1]
        document.term_position('kota').should eq [2]
      end

      it 'returns array for multiple occurences' do
        doc = InvertedIndex::Document.new('Ala ma kota i ola ma kota', 0)
        doc.term_position('ma').should eq [1, 5]
        doc.term_position('kota').should eq [2, 6]
      end
    end

    context "document doesn't contain term" do
      it 'returns empty array' do
        document.term_position('ela').should eq []
      end
    end
  end
end
