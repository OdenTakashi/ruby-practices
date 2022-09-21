# frozen_string_literal: true

require_relative 'path_list'
require 'optparse'

class PathListFormatter
  MAX_COLUMN_LENGTH = 3
  MAX_NUMBER_OF_CHARACTER = 23

  def initialize(argv)
    @options = argv.getopts('arl')
    flags = @options['a'] ? File::FNM_DOTMATCH : 0
    @path_list = PathList.new(argv, flags)
    reverse_list if @options['r']
    @path_list.search_detail if @options['l']
  end

  def run
    @options['l'] ? output_long_format : output_standard_format
  end

  private

  def reverse_list
    @path_list.list.reverse!
  end

  def count_files_mod_by_three
    @path_list.list.count % MAX_COLUMN_LENGTH
  end

  def max_line_length
    if count_files_mod_by_three.zero?
      @path_list.list.count / MAX_COLUMN_LENGTH
    else
      (@path_list.list.count / MAX_COLUMN_LENGTH).next
    end
  end

  def adjust_number_of_files
    unless count_files_mod_by_three == 0
      (MAX_COLUMN_LENGTH - count_files_mod_by_three).times { @path_list.list.push(Path.new(nil))}
    end
    @path_list.list
  end

  def group_paths
    adjust_number_of_files.each_slice(max_line_length).to_a.transpose
  end

  def extract_names(paths)
    paths.map { |path| path.name&.ljust(MAX_NUMBER_OF_CHARACTER) }
  end

  def gather_max_length
    {
      links: @path_list.list.map { |path| path.links.to_s.size }.max,
      user_name: @path_list.list.map { |path| path.user_name.size }.max,
      group_name: @path_list.list.map { |path| path.group_name.size }.max,
      file_size: @path_list.list.map { |path| path.file_size.to_s.size }.max,
      last_update_time: @path_list.list.map { |path| path.last_update_time.size }.max
    }
  end

  def output_long_format
    max_length = gather_max_length
    @path_list.list.each do |path|
      print(
        path.type,
        path.permission,
        path.links.to_s.rjust(max_length[:links] + 1),
        path.user_name.rjust(max_length[:user_name] + 1),
        path.group_name.rjust(max_length[:group_name] + 1),
        path.file_size.to_s.rjust(max_length[:file_size] + 1).to_s,
        path.last_update_time.rjust(max_length[:last_update_time] + 1),
        " #{path.name.ljust(MAX_NUMBER_OF_CHARACTER)}\n"
      )
    end
  end

  def output_standard_format
    group_paths.each do |files|
      puts extract_names(files).join(' ')
    end
  end
end
