#!/usr/bin/env ruby

require 'hiki/app'
require 'rubygems'
require 'rack'

app = Rack::Builder.new{
  use Rack::Lint
  use Rack::ShowExceptions
  #use Rack::ShowStatus
  use Rack::CommonLogger
  use Rack::Static, :urls => ['/theme'], :root => '.'
  run Hiki::App.new
}.to_app
options = {
  :Port => 9292,
  :Host => '0.0.0.0',
  :AccessLog => []
}
Rack::Handler::Mongrel.run(app, options)
