# frozen_string_literal: true

class File
  MAX_NUMBER_OF_CHARCTERS = 23
  attr_reader :files

  def initialize(argv)
    directory_names = argv.empty? ? [Dir.pwd] : argv
    @files = get_files(directory_names).flatten.sort.map { |file| file.ljust(MAX_NUMBER_OF_CHARCTERS) }
  end

  def get_files(directories)
    directories.each_with_object([]) do |directory, files|
      files << Dir.glob('*', base: directory)
    end
  end
end
