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

  def result_with_l_option
    @list.files.each do |file|
      user_id = Process.uid
      user_name = Etc.getpwuid(user_id).name
      group_id   = Process.gid
      group_name = Etc.getgrgid(group_id).name
      file_path = File.expand_path(file, @list.directory_name)
      stat = File::Stat.new(file_path)
      permission_octal = stat.mode.to_s(8)
      permission = conversion_permission(permission_octal)

      puts "#{permission} #{stat.nlink} #{user_name} #{group_name}  #{File.size(file_path)} #{stat.mtime.to_s.slice!(6..15)} #{file} "
    end
  end

  def result(grouped_files)
    grouped_files.each do |files|
      files_arranged = arrange_character_length(files)
      puts files_arranged.join(' ')
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
      permission_conversioned.prepend('--')
    when '40'
      permission_conversioned.prepend('d-')
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
