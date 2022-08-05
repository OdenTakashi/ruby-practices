class ReverseFile
  def initialize(real_files)
    @real_files = real_files
  end

  def reverse_files
    @real_files.files.reverse!
    result
  end

  def result
    @real_files.result
  end
end
