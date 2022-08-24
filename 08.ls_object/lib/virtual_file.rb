# frozen_string_literal: true

class VirtualFile
  attr_reader :files, :directory_names

  def initialize(argv, flags = 0)
    @directory_name = argv.empty? ? Dir.pwd : argv[0]
    @files = get_files(flags).flatten.sort
  end

  private

  def get_files(flags)
    Dir.glob('*', flags, base: @directory_name)
  end
end
