require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require 'rspec/autorun'

  RSpec.configure do |config|
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
