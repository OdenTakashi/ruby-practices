# frozen_string_literal: true

require_relative('file')
require_relative('list_builder')

class Director
  def initialize(director)
    @director = director
  end

  def work
    @director.complete_files
    grouped_files = @director.group_files
    @director.result(grouped_files)
  end
end

list_builder = ListBuilder.new(ARGV)
director = Director.new(list_builder)
director.work
