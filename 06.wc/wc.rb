# frozen_string_literal: true

# frozen_file_contenting_literal: true

require 'optparse'

def main
  params = {}
  opt = OptionParser.new
  opt.on('-l', '--onlylines') { |v| v }
  opt.parse!(ARGV, into: params)

  ARGV.empty? ? count_sizes_of_stdin(params) : count_sizes_of_file(params)
end

def count_lines(file_content)
  file_content.count("\n")
end

def count_words(file_content)
  ary = file_content.split(/\s+/)
  ary.size
end

def count_bytes(file_content)
  file_content.bytesize
end

def count_sizes_of_file(params)
  filenames = ARGV
  contents = filenames.map do |filename|
    file_content = File.read(filename)
    { lines: count_lines(file_content), words: count_words(file_content), bytes: count_bytes(file_content), file_name: filename }
  end
  contents << total_result(contents) if filenames.count > 1
  contents = remove_words_bytes(contents) if params[:onlylines]
  output_info_of_file(contents)
end

def count_sizes_of_stdin(params)
  standard_input = $stdin.read
  standard_contents =
    [{ lines: count_lines(standard_input), words: count_words(standard_input), bytes: count_bytes(standard_input) }]
  standard_contents = remove_words_bytes(standard_contents) if params[:onlylines]
  output_info_of_stdin(standard_contents)
end


def total_result(contents)
  total = { lines: 0, words: 0, bytes: 0, file_name: 'total' }
  contents.each do |hash|
    total[:lines] += hash[:lines]
    total[:words] += hash[:words]
    total[:bytes] += hash[:bytes]
  end
  total
end

def remove_words_bytes(contents)
  contents.each do |content|
    content.delete(:words)
    content.delete(:bytes)
  end
  contents
end

def output_info_of_file(contents)
  contents.each do |content|
    puts "#{content[:lines]} #{content[:words]} #{content[:bytes]} #{content[:file_name]}"
  end
end

def output_info_of_stdin(standard_contents)
  standard_contents.each do |standard_content|
    puts "#{standard_content[:lines]} #{standard_content[:words]} #{standard_content[:bytes]}"
  end
end

main
