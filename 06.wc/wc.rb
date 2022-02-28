# frozen_file_contenting_literal: true

require 'optparse'

def wc_main(filename)
  file_content = ARGV.empty? ? filename : File.read(filename)
  { lines: count_lines(file_content), words: count_words(file_content), bytes: count_bytes(file_content), file_name: filename }
end

def count_lines(file_content)
  file_content.count("\n")
end

def count_words(file_content)
  ary = file_content.split(/\s+/)
  ary.size
end

def count_bytes(file_content)
  # File.size(filename)
	file_content.bytesize
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

def output(contents)
	contents.each do |content|
		puts "#{content[:lines]} #{content[:words]} #{content[:bytes]} #{content[:file_name]}"
	end
end

def main
	params = {}
	opt = OptionParser.new
	opt.on('-l') { |v| v }
	opt.parse!(ARGV, into: params)

  filesnames = ARGV.empty? ? gets.split : ARGV
	contents = filesnames.map do |filename|
		wc_main(filename)
	end

  contents << total_result(contents) if filesnames.count > 1
	if params[:l]
		contents.each do |content|
			content.delete(:words)
			content.delete(:bytes)
		end
	end

  output(contents)
end

main
