# frozen_string_literal: true

class VirtualFile
  MAX_NUMBER_OF_CHARCTERS = 23
  attr_reader :files, :directory_names

  def initialize(argv, flags = 0)
    @directory_names = argv.empty? ? [Dir.pwd] : argv
    @files = get_files(flags).flatten.sort.map { |file| file.ljust(MAX_NUMBER_OF_CHARCTERS) }
  end

  private

  def get_files(flags)
    @directory_names.each_with_object([]) do |directory, files|
      files << Dir.glob('*', flags, base: directory)
    end
  end
end
