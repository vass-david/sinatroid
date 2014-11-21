require 'rubygems'
require 'bundler/setup'

require 'sinatroid/env'
Sinatroid::Environment.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'sinatroid/app'
run Sinatroid::Application
