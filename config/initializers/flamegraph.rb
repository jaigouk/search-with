begin
  require "stackprof"
rescue LoadError
  STDERR.puts "Please require the stackprof gem falling back to fast_stack"
  require "fast_stack"
end
require 'flamegraph'
