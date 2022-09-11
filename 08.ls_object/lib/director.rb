# frozen_string_literal: true

require_relative 'virtual_file'
require_relative 'list_builder'
require 'optparse'

class Director
  def initialize(argv)
    @options = argv.getopts('arl')
    flags = @options['a'] ? File::FNM_DOTMATCH : 0
    @builder = ListBuilder.new(argv, flags)
  end

  def result
    @builder.reverse_files if @options['r']
    @options['l'] ? run_with_l_option : run
  end

  private

  def run
    @builder.adjust_number_of_files
    grouped_files = @builder.group_files
    @builder.result(grouped_files)
  end

  def output_long_format
    @builder.output_long_format
  end
end
