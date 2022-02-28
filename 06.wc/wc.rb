# frozen_file_contenting_literal: true

SPACE = '       '

def wc_main(filename)
  file_content = File.read(filename)
  { lines: count_lines(file_content), words: count_words(file_content), bytes: count_bytes(filename), file_name: filename }
end

def count_lines(file_content)
  file_content.count("\n")
end

def count_words(file_content)
  ary = file_content.split(/\s+/)
  ary.size
end

def count_bytes(filename)
  File.size(filename)
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

# def output_total_result(total)
  # puts "#{total[:lines]} #{total[:words]} #{total[:bytes]} total"
# end

def output(contents)
	contents.each do |content|
		puts "#{content[:lines]} #{content[:words]} #{content[:bytes]} #{content[:file_name]}"
	end
end

def main
  filesnames = ARGV
  # ary = []
  # filesnames.each do |filename|
  #   file_content = File.read(filename)
		
  #   hash = { lines: file_lines(file_content), words: words_count(file_content), bytes: bytes_values(filename) }
  #   ary << hash
  #   wc_main(file_content, filename)
  # end
  # total_result(ary) if filesnames.count > 1

  # content = [
  #   { lines: lines, words: words, bytes: bytes, file_name: file_name }
  #   { lines: lines, words: words, bytes: bytes, file_name: file_name }
  # ]

	contents = filesnames.map do |filename|
		wc_main(filename) # { lines: lines, words: words, bytes: bytes, file_name: file_name }
	end

  contents << total_result(contents) if filesnames.count > 1
  output(contents)
end

main
