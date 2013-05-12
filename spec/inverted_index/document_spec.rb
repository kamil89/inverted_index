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
        document.term_position('ala').should eq 0
        document.term_position('ma').should eq 1
        document.term_position('kota').should eq 2
      end
    end

    context "document doesn't contain term" do
      it 'returns nil' do
        document.term_position('ela').should be_nil
      end
    end
  end
end
