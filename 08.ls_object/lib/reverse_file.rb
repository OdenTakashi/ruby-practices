class ReverseFile
  def initialize(real_files)
    @real_files = real_files
  end

  def result
    @real_files.files.reverse!
    @real_files.result
  end
end
