# frozen_string_literal: true

require 'etc'

class ListBuilder
  MAX_COLUMN_LENGTH = 3
  MAX_NUMBER_OF_CHARACTER = 23
  PERMISSION_TABLE = { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }.freeze

  def initialize(argv, flags = 0)
    @list = VirtualFile.new(argv, flags)
  end

  # ファイル数が3の倍数になるようにnilを追加
  def adjust_number_of_files
    case count_files_mod_by_three
    when 1
      2.times { @list.files.push(nil) }
    when 2
      @list.files.push(nil)
    end
  end

  def group_files
    @list.files.each_slice(max_line_length).to_a.transpose
  end

  def reverse_files
    @list.files.reverse!
  end

  def result(grouped_files)
    grouped_files.each do |files|
      files_arranged = arrange_character_length(files)
      puts files_arranged.join(' ')
    end
  end

  def get_long_formats
    @list.files.each_with_object([]) do |file, long_formats|
      file_path = File.expand_path(file, @list.directory_name)
      stat = File::Stat.new(file_path)
      permission_octal = stat.mode.to_s(8)

      long_format = {
        permission: conversion_permission(permission_octal),
        links: stat.nlink.to_s,
        user_name: Etc.getpwuid(stat.uid).name,
        group_name: Etc.getgrgid(stat.gid).name,
        file_size: File.size(file_path).to_s,
        last_update_time: get_mtime(stat),
        file_name: file
      }

      long_formats << long_format
    end
  end

  def get_max_length(_formats)
    long_formats = get_long_formats
    links = []
    user_name = []
    group_name = []
    file_size = []
    last_update_time = []

    long_formats.each do |long_format|
      links << long_format[:links]
      user_name << long_format[:user_name]
      group_name << long_format[:group_name]
      file_size << long_format[:file_size]
      last_update_time << long_format[:last_update_time]
    end

    {
      links: get_maximum_length(links),
      user_name: get_maximum_length(user_name),
      group_name: get_maximum_length(group_name),
      file_size: get_maximum_length(file_size),
      last_update_time: get_maximum_length(last_update_time)
    }
  end

  def get_maximum_length(value)
    value.map(&:length).max
  end

  def result_with_l_option
    max_length = get_max_length(get_long_formats)
    get_long_formats.each do |long_format|
      puts "#{long_format[:permission]}  #{long_format[:links].rjust(max_length[:links])} #{long_format[:user_name].ljust(max_length[:user_name])}  #{long_format[:group_name].ljust(max_length[:group_name])}  #{long_format[:file_size].rjust(max_length[:file_size])} #{long_format[:last_update_time].rjust(max_length[:last_update_time])} #{long_format[:file_name].ljust(MAX_NUMBER_OF_CHARACTER)} "
    end
  end

  def get_mtime(stat)
    if (Time.now - stat.mtime) / (60 * 60 * 24) >= (365 / 2) || (Time.now - stat.mtime).negative?
      stat.mtime.strftime('%_m %_d  %Y')
    else
      stat.mtime.strftime('%_m %_d %H:%M')
    end
  end

  private

  def conversion_permission(permission_octal)
    overhaul_permission = permission_octal.to_i.digits.reverse
    # [-3..]によって権限の値のみ操作
    permission_conversioned = overhaul_permission[-3..].map do |number|
      PERMISSION_TABLE[number]
    end
    # [0..1]によってファイルかディレクトリを判定
    case overhaul_permission[0..1].join
    when '10'
      permission_conversioned.prepend('-')
    when '40'
      permission_conversioned.prepend('d')
    end
    permission_conversioned.join
  end

  def arrange_character_length(files)
    files.map { |file| file&.ljust(MAX_NUMBER_OF_CHARACTER) }
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
