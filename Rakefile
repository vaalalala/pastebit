build_scripts_dir = File.join(File.dirname(__FILE__), 'build')
Dir.glob(File.join(build_scripts_dir, 'rake_*')).each {|r| require r }

task :default => [:test]

task :test do
  task :default => [:spec, :features]
end
