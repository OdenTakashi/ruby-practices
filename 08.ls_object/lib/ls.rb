class Ls
  attr_reader :directory_names

  def initialize(argv)
    @directory_names = argv.empty? ? [Dir.pwd] : argv
  end
end
