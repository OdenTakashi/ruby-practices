class ListBuilder
  def initialize(argv)
    @list = File.new(argv)
  end

  def count_files_mod_by_three
    @files.count % 3
  end

#ファイル数が3の倍数になるようにnilを追加
  def complete_files
    case count_files_mod_by_three
    when 1
      2.times {@files.push(nil)}
    when 2
      1.times {@files.push(nil)}
    end
  end

  def get_max_line_length
    if count_files_mod_by_three.zero?
      @files.count / MAX_COLUMN_LENGTH
    else
      (@files.count / MAX_COLUMN_LENGTH).next
    end
  end

  def result
    transposed_files.each do |file|
      puts file.join(' ')
    end
  end
end
