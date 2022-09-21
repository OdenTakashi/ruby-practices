# frozen_string_literal: true

require_relative '../lib/path_list_formatter'

path_list = PathList.new(ARGV)
formatter = PathListFormatter.new(path_list)
formatter.run

