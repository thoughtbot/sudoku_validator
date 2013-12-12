require 'cucumber'
require 'cucumber/rake/task'
require 'Open3'

Cucumber::Rake::Task.new(:default) do |t|
  t.cucumber_opts = "features --format pretty -x"
  t.fork = false
end
