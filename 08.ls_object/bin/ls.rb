# frozen_string_literal: true

require_relative '../lib/path_list_formatter'
require 'optparse'

options = ARGV.getopts('arl')
path_list = PathList.new(ARGV, dotmatch: options['a'])
formatter = PathListFormatter.new(path_list, reverse: options['r'], long_format: options['l'])
formatter.run(long_format: options['l'])
