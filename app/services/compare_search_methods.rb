# frozen_string_literal: true
require 'benchmark/ips'
require_relative '../../lib/benchmark_ips_extension'
require_relative '../../lib/capture_stdout'

class CompareSearchMethods < BaseService
  attr_reader :elastic, :materialized

  def initialize()
    @elastic = GetFacetsSearchResults.new(:elastic)
    @materialized = GetFacetsSearchResults.new(:materialized)
    @entries = []
  end

  def call(params:, time:, warmup:)
    compare = Benchmark.ips do |x|
      x.time = time
      x.warmup = warmup
      x.report("ElasticSeach") { @elastic.call(params) }
      x.report("Materialized View") { @materialized.call(params) }
      x.compare!
    end

    compare.entries.each {|d| @entries << d.to_s }
    final_result = Capture.capture do
      compare.run_comparison
    end

    { entries: @entries, result: final_result.stdout }
  end

  private


end
