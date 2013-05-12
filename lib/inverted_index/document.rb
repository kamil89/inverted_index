module InvertedIndex
  class Document
    attr_reader :body, :id

    def initialize(body, id)
      @body = body
      @id = id
    end

    def terms
      @terms ||= @body.scan(/\w+/).map(&:downcase)
    end

    def term_position(term)
      terms.index(term)
    end
  end
end
