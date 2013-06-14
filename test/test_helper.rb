$: << File.dirname(__FILE__) + '/../lib'

require "bundler/setup"
require "minitest/pride"
require "minitest/autorun"
require "pandemonium/boot"
require "spawns"

ENV["TEST"] = "yes"

Ohm.flush
