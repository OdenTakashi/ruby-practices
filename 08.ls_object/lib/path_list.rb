# frozen_string_literal: true

require_relative('path')

class PathList
  attr_reader :list

  def initialize(argv, flags)
    @parent_directory = argv.empty? ? Dir.pwd : argv[0]
    paths = fetch_paths(flags).sort
    @list = paths.map { |path| Path.new(path) }
  end

  def search_detail
    @list.each do |list|
      list.search_detail(@parent_directory)
    end
  end

  private

  def fetch_paths(flags)
    Dir.glob('*', flags, base: @parent_directory)
  end
end
