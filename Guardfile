guard 'rspec', :cli => "--color --format nested" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^views/(.+)\.haml$})
  watch(%r{^pastebit\.rb$})     { |m| "spec/pastebit_spec.rb" }
end

guard 'bundler' do
  watch('Gemfile')
end
