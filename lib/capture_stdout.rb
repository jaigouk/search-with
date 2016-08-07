# frozen_string_literal: true
require 'stringio'
require 'ostruct'

class Capture

  def self.capture &block

    # redirect output to StringIO objects
    stdout, stderr = StringIO.new, StringIO.new
    $stdout, $stderr = stdout, stderr

    result = block.call

    # restore normal output
    $stdout, $stderr = STDOUT, STDERR

    OpenStruct.new result: result, stdout: stdout.string, stderr: stderr.string
  end
end
