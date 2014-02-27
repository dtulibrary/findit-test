require 'bundler/setup'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec/core/rake_task'

SPEC_SUITES = [
  { :id => :getit, :title => 'GetIt', :dirs => %w(spec/getit) },
  { :id => :resolver, :title => 'FindIt resolver', :dirs => %w(spec/resolver) },
  { :id => :relevance, :title => 'FindIt relevance ranking', :dirs => %w(spec/relevance_ranking) }
]

namespace :spec do
  namespace :suite do
    SPEC_SUITES.each do |suite|
      desc "Run all specs in #{suite[:title]} spec suite"
      RSpec::Core::RakeTask.new(suite[:id]) do |t|
        spec_files = []
        if suite[:files]
          suite[:files].each { |glob| spec_files += Dir[glob] }
        end

        if suite[:dirs]
          suite[:dirs].each { |glob| spec_files += Dir["#{glob}/**/*_spec.rb"] }
        end

        t.rspec_opts = ["-c", "-f progress", "-t ~wip", "-r ./spec/support/#{suite[:id]}_helper.rb"]
        t.pattern = spec_files
      end
    end
  end
end
