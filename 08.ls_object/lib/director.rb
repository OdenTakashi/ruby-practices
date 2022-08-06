# frozen_string_literal: true

require_relative('file')
require_relative('list_builder')

class Director
  def initialize(director)
    @director = director
  end

  def work
    @director.adjust_number_of_iles
    grouped_files = @director.group_files
    @director.result(grouped_files)
  end
end

list_builder = ListBuilder.new(ARGV)
director = Director.new(list_builder)
director.work
