require_relative('reverse_file')
require_relative('all_file')
require('optparse')

class Ls
  attr_reader :files
  MAX_COLUMN_LENGTH = 3
  MAX_NUMBER_OF_CHARCTERS = 23

#-aオプション適用時flagsにFile::FNM_DOTMATCHを当て隠しファイルを取得
  def initialize(argv, flags = 0)
    directory_names = argv.empty? ? [Dir.pwd] : argv
    @files = get_files(directory_names, flags).flatten.sort.map{|file| file.ljust(MAX_NUMBER_OF_CHARCTERS)}
  end

  def get_files(directories, flags)
    directories.each_with_object([]) do |directory, files|
      files << Dir.glob('*', flags, base: directory)
    end
  end

  def count_files_mod_by_three
    @files.count % 3
  end

#ファイル数が3の倍数になるようにnilを追加
  def complete_files
    case count_files_mod_by_three
    when 1
      2.times {@files.push(nil)}
    when 2
      1.times {@files.push(nil)}
    end
  end

  def get_max_line_length
    if count_files_mod_by_three.zero?
      @files.count / MAX_COLUMN_LENGTH
    else
      (@files.count / MAX_COLUMN_LENGTH).next
    end
  end

  def ls_main
    complete_files
    grouped_files = @files.each_slice(get_max_line_length).to_a
    transposed_files = grouped_files.transpose
  end  

  def result
    transposed_files = ls_main
    transposed_files.each do |file|
      puts file.join(' ')
    end
  end
end

params = ARGV.getopts('rla')

file = AllFile.new(ReverseFile.new(Ls.new(ARGV, File::FNM_DOTMATCH)))
file.result
