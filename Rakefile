require 'bundler/setup'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec/core/rake_task'

desc "Run tests" 
RSpec::Core::RakeTask.new(:passing) do |spec|
  spec.rspec_opts = ["-c", "-f progress", "-t ~wip", "-r ./spec/spec_helper.rb"]
end

task :default => :passing