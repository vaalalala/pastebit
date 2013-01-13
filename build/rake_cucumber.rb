require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |task|
  task.cucumber_opts = "features --format pretty"
end
