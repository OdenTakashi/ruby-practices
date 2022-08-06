class AllFile
  attr_reader :real_files
  def initialize(real_files)
    @real_files = real_files
  end

  def result
    @real_files.result
  end
end
