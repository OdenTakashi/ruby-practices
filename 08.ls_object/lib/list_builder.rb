# frozen_string_literal: true

class ListBuilder
  MAX_COLUMN_LENGTH = 3

  def initialize(argv, flags = 0)
    @list = File.new(argv, flags)
  end

  # ファイル数が3の倍数になるようにnilを追加
  def adjust_number_of_iles
    case count_files_mod_by_three
    when 1
      2.times { @list.files.push(nil) }
    when 2
      @list.files.push(nil)
    end
  end

  def group_files
    @list.files.each_slice(max_line_length).to_a.transpose
  end

  def result(transposed_files)
    transposed_files.each do |file|
      puts file.join(' ')
    end
  end

  def reverse_files
    @list.files.reverse!
  end

  private

  def count_files_mod_by_three
    @list.files.count % 3
  end

  #メソッドは動詞で始めるべきだが使用箇所的に違和感がある。
  def max_line_length
    if count_files_mod_by_three.zero?
      @list.files.count / MAX_COLUMN_LENGTH
    else
      (@list.files.count / MAX_COLUMN_LENGTH).next
    end
  end
end
