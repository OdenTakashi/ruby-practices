# frozen_string_literal: true

require 'etc'

class Path
  attr_reader :name, :links, :user_name, :group_name, :file_size, :last_update_time, :permission, :type

  PERMISSION_TABLE = { '0' => '---', '1' => '--x', '2' => '-w-', '3' => '-wx', '4' => 'r--', '5' => 'r-x', '6' => 'rw-', '7' => 'rwx' }.freeze

  def initialize(path)
    @name = path
  end

  def search_detail(parent_directory)
    expand_path = File.expand_path(@name, parent_directory)
    stat = File::Stat.new(expand_path)

    @type = judge_type(stat)
    @permission = convert_permission(stat)
    @links = stat.nlink
    @user_name = Etc.getpwuid(stat.uid).name
    @group_name = Etc.getgrgid(stat.gid).name
    @file_size = File.size(expand_path)
    @last_update_time = get_mtime(stat)
  end

  private

  def get_mtime(stat)
    if (Time.now - stat.mtime) / (60 * 60 * 24) >= (365 / 2) || (Time.now - stat.mtime).negative?
      stat.mtime.strftime('%_m %_d  %Y')
    else
      stat.mtime.strftime('%_m %_d %H:%M')
    end
  end

  def judge_type(stat)
    stat.directory? ? 'd' : '-'
  end

  def convert_permission(stat)
    permission = stat.mode.to_s(8)[-3..].split('')
    permission.map { |n| PERMISSION_TABLE[n] }.join
  end
end
