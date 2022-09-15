require_relative('path')

class PathList
  attr_reader :list
  def initialize(argv, flags)
    parent_directory = argv.empty? ? Dir.pwd : argv[0]
    paths = get_paths(parent_directory, flags).sort
    @list = paths.map{ |path| Path.new(path) }
  end

  def get_paths(parent_directory, flags)
    Dir.glob('*', flags, base: parent_directory)
  end
end

