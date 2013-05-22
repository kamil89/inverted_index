module InvertedIndex
  class IndexCalculator

    def self.calculate_positions(terms, documents)
      results = {}

      terms.each do |term|
        documents.each do |document|
          index = document.term_position(term)
          unless index.empty?
            results[term] ||= []
            results[term] << [document.id, index]
          end
        end
      end

      results
    end

  end
end
