require 'rspec'
require './application'
require 'pry'
require 'watir-webdriver'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
