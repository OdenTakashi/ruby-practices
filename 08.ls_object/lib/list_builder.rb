# frozen_string_literal: true
require 'etc'

class ListBuilder
  MAX_COLUMN_LENGTH = 3
  MAX_NUMBER_OF_CHARACTER = 23

  def initialize(argv, flags = 0)
    @list = VirtualFile.new(argv, flags)
  end

  # ファイル数が3の倍数になるようにnilを追加
  def adjust_number_of_files
    case count_files_mod_by_three
    when 1
      2.times { @list.files.push(nil) }
    when 2
      1.times { @list.files.push(nil) }
    end
  end

  def group_files
    @list.files.each_slice(max_line_length).to_a.transpose
  end

  def reverse_files
    @list.files.reverse!
  end

  def result_with_l_option
    @list.files.each do |file|
      file_path = File.expand_path(file)
      p file_path
      
    end
  end

  def result(transposed_files)
    transposed_files.each do |files|
      files_arranged = arrange_character_length(files)
      puts files_arranged.join(' ')
    end
  end

  private

  def arrange_character_length(files)
    files.map {|file| file.ljust(MAX_NUMBER_OF_CHARACTER) unless file.nil?}
  end

  def count_files_mod_by_three
    @list.files.count % 3
  end

  def max_line_length
    if count_files_mod_by_three.zero?
      @list.files.count / MAX_COLUMN_LENGTH
    else
      (@list.files.count / MAX_COLUMN_LENGTH).next
    end
  end
end
