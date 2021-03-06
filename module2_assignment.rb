# =>  words analyzer for each line in the file
class LineAnalyzer
  # =>  highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  # =>  highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  # =>  content          - the string analyzed (provided)
  # =>  line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number
  
  # =>  initialize() - taking a line of text (content) and a line number
  # =>  calculate_word_frequency() - calculates result

  # =>  take in a line of text and line number
  # =>  initialize the content and line_number attributes
  # =>  call the calculate_word_frequency() method.
  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    self.calculate_word_frequency
  end
  
  # =>  calculate the maximum number of times a single word appears within
  #     provided content and store that in the highest_wf_count attribute.
  # =>  identify the words that were used the maximum number of times and
  #     store that in the highest_wf_words attribute.
  def calculate_word_frequency
    # =>  initialize words and count in a hash and default the value to be 0
    words = Hash.new(0)

    # =>  parse the content and store the count of the word one by one, case 
    #    will be ignored when counting
    @content.split.each do |string|
      words[string.downcase] += 1
    end

    # =>  the default value of highest count should be 0, and the default of 
    #     the highest count words should be empty.
    @highest_wf_count ||= 0
    @highest_wf_words ||= nil

    # =>  loop through the hash stored before to check the highest count of 
    #     all the words
    words.each_pair do |key, value|
        @highest_wf_count = value if value > @highest_wf_count
    end

    # =>  loop through the hash and store the words whose count is the highest
    @highest_wf_words = words.select {|k,v| v == @highest_wf_count }
                             .keys
  end
end

class Solution

  # =>  analyzers - an array of LineAnalyzer objects for each line in the file
  # =>  highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  # =>  highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #     equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  
  # =>  analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  # =>  calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #     highest_count_words_across_lines attribute values
  # =>  print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #     highest_count_words_across_lines in the specified format

  # =>  Initialize the solution class with analyzers array declared, in this case its not nil before read file.
  def initialize
    @analyzers = Array.new
  end
  
  # =>  Read the 'test.txt' file in lines 
  # =>  Create an array of LineAnalyzers for each line in the file
  def analyze_file()
    # => Catch the exception if the file is not found 
    begin
      # =>  open the test.txt file
      text = File.open('test.txt')

      # =>  store each line as an object of LineAnalyzer
      text.each_with_index do |line, index|
        @analyzers << LineAnalyzer.new(line, index)
      end
    rescue Exception
      # =>  print out error message if there is an error
      puts e.message
    end
  end
  
  # =>  calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #     and stores this result in the highest_count_across_lines attribute.
  # =>  identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #     attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency
    # =>  sort the analyzer list and find the hight words count
    @highest_count_across_lines = @analyzers.sort {|x,y| y.highest_wf_count <=> x.highest_wf_count}
                                            .first.highest_wf_count

    # =>  select all the analyzers with the highest word count
    @highest_count_words_across_lines = @analyzers.select { |x| x.highest_wf_count == @highest_count_across_lines}
  end
  
  # => print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |analyzer|                                
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
  end
end
