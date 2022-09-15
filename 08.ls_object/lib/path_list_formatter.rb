require_relative 'path_list'

class PathListFormatter
  MAX_COLUMN_LENGTH = 3
  MAX_NUMBER_OF_CHARACTER = 23

  def initialize(argv)
    @path_list = PathList.new(argv)
  end

  def output_standard_format
    group_paths.each do |files|
      puts extract_names(files).join(' ')
    end
  end

  def extract_names(paths)
    paths.map { |path| path.name&.ljust(MAX_NUMBER_OF_CHARACTER)}
  end

  def group_paths
    adjust_number_of_files.each_slice(max_line_length).to_a.transpose
  end

  def count_files_mod_by_three
    @path_list.list.count % 3
  end

  def max_line_length
    if count_files_mod_by_three.zero?
      @path_list.list.count / MAX_COLUMN_LENGTH
    else
      (@path_list.list.count / MAX_COLUMN_LENGTH).next
    end
  end

  def adjust_number_of_files
    case count_files_mod_by_three
    when 0
      @path_list.list
    when 1
      2.times { @path_list.list.push(Path.new(nil)) }
    when 2
      @path_list.list.push(Path.new(nil))
    end
  end
end

PathListFormatter.new(ARGV).output_standard_format
