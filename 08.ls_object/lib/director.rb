# frozen_string_literal: true
require_relative 'virtual_file'
require_relative 'list_builder'
require 'optparse'

class Director
  def initialize(argv)
    @options = argv.getopts('arl')
    flags = @options['a'] ? File::FNM_DOTMATCH : 0
    @director = ListBuilder.new(argv, flags)
  end

  def work
    @director.adjust_number_of_iles
    grouped_files = @director.group_files
    @director.result(grouped_files)
  end

  def work_with_l_option
    @director.result_with_l_option
  end

  def result
    @director.reverse_files if @options['r']
    @options['l'] ? work_with_l_option : work
  end
end

Director.new(ARGV).result
