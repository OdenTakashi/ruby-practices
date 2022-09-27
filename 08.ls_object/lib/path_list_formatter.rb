# frozen_string_literal: true

require_relative 'path_list'

class PathListFormatter
  MAX_COLUMN_LENGTH = 3

  def initialize(path_list, reverse: false, long_format: false)
    @path_list = path_list
    reverse_list if reverse
    @path_list.search_detail if long_format
  end

  def run(long_format: false)
    long_format ? output_long_format : output_standard_format
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
    (MAX_COLUMN_LENGTH - count_files_mod_by_three).times { @path_list.list.push(Path.new(nil)) } unless count_files_mod_by_three.zero?
    @path_list.list
  end

  def group_paths
    adjust_number_of_files.each_slice(max_line_length).to_a.transpose
  end

  def extract_names(paths)
    max_length = @path_list.list.map { |path| path.name&.size }.compact.max
    #パス名を最大文字数+6に設定。+6は標準lsの確かな数値はわからなかったので憶測です。
    paths.map { |path| path.name&.ljust(max_length + 6) }
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
        " #{path.name}\n"
      )
    end
  end

  def output_standard_format
    group_paths.each do |files|
      puts extract_names(files).join(' ')
    end
  end
end
