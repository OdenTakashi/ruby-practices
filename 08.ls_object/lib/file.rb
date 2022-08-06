class File
  def initialize
    directory_names = argv.empty? ? [Dir.pwd] : argv
    @files = get_files(directory_names).flatten.sort.map{|file| file.ljust(MAX_NUMBER_OF_CHARCTERS)}
  end

  def get_files(directories)
    directories.each_with_object([]) do |directory, files|
      files << Dir.glob('*', base: directory)
    end
  end
end
