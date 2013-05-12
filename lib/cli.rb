module InvertedIndex
  class Cli
    attr_reader :file_path

    def self.start(file_path)
      self.new(file_path)
    end

    def initialize(file_path)
      @file_path = file_path.to_s
      check_argument()
      run_inverted_index()
    end

    def run_inverted_index
      @file_content = File.open(@file_path).read

      documents = load_documents()
      terms = documents.map(&:terms).flatten.uniq.sort
      results = IndexCalculator.calculate_positions(terms, documents)

      info("Liczba dokumentów: #{documents.size}")
      info("Liczba termów: #{terms.size}")
      info("-------------------------------------")
      print_result(results)
    end

    def check_argument
      error("No file provided.") if @file_path.empty?
      error("File #{@file_path} doesn't exist.") unless File.exist?(@file_path)
      error("File #{@file_path} is empty.") if File.size(@file_path) == 0
    end

    def error(message)
      puts(message)
      exit
    end

    def info(message)
      puts(message)
    end

    def load_documents
      @file_content.split("\n").map.with_index do |line, index|
        Document.new(line, index)
      end
    end

    def print_result(results)
      format = "%-20s\t%-100s\n"
      printf(format, "Term", "Wystąpienia")
      printf(format, "----", "-----------")
      results.each do |key, value|
        wyst = value.map {|a| "(#{a.join(", ")})"}.join(", ")
        printf(format, key, wyst)
      end
    end

  end
end
