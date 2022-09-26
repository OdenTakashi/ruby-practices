# frozen_string_literal: true

require_relative '../lib/path_list_formatter'
require 'optparse'

options = ARGV.getopts('arl')
path_list = PathList.new(ARGV, options['a'])
formatter = PathListFormatter.new(path_list, options['r'], options['l'])
formatter.run(options['l'])
