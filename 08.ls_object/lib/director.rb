# frozen_string_literal: true

require_relative('file')
require_relative('list_builder')
require('optparse')

class Director
  def initialize(argv)
    @options = ARGV.getopts('arl')
    flags = @options['a'] ? File::FNM_DOTMATCH : 0
    @director = ListBuilder.new(argv, flags)
  end

  # メソッドを変数に入れていない点が違和感
  def work
    @director.adjust_number_of_iles
    grouped_files = @director.group_files
    @director.result(grouped_files)
  end

  def work_with_l_option; end

  def result
    @director.reverse_files if @options['r']
    @options['l'] ? work_with_l_option : work
  end
end

# オプションの処理はディレクタークラスがやるべき
# なのでオプション処理はメソッド内でやるべき？

Director.new(ARGV).result
