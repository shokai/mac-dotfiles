#!/usr/bin/env ruby
require 'webrick'

port = (ARGV.shift||8080).to_i

server = WEBrick::HTTPServer.new({
  :DocumentRoot => './',
  :BindAddress => '0.0.0.0',
  :Port => port
})


['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.start
