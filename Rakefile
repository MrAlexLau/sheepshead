#!/usr/bin/env rake

task :console do
  require 'irb'

  $LOAD_PATH << '.'
  Dir["lib/*.rb"].each { |f| require f }
  Dir["lib/io/*.rb"].each { |f| require f }
  Dir["lib/models/*.rb"].each { |f| require f }
  Dir["lib/services/*.rb"].each { |f| require f }

  ARGV.clear
  IRB.start
end
