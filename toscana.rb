#!/usr/bin/env ruby
require "optparse"
require 'json'
require 'json/minify'

class disk
  attr_accesor :type, :size, :position
end

options = {}

optparse = OptionParser.new do |opts|
  opts.on("-c", "--configfile FILE", "Read config from FILE") do |file|
    options[:configfile] = file
  end

  opt.on("-d", "--device NAME", "Specify device name [sdX]") do |device_name|
    options[:device_name] = device_name
  end


end

if options[:configfile]


cli = HighLine.new
