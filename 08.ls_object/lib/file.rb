# frozen_string_literal: true

class File
  MAX_NUMBER_OF_CHARCTERS = 23
  attr_reader :files

  #ファイルを取得してくるのみのクラスで出力のためのpaddingは違和感
  def initialize(argv, flags = 0)
    directory_names = argv.empty? ? [Dir.pwd] : argv
    @files = get_files(directory_names, flags).flatten.sort.map { |file| file.ljust(MAX_NUMBER_OF_CHARCTERS) }
  end

  private

  def get_files(directories, flags)
    directories.each_with_object([]) do |directory, files|
      files << Dir.glob('*', flags, base: directory)
    end
  end
end
