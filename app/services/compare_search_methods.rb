# frozen_string_literal: true
require 'benchmark/ips'
require_relative '../../lib/benchmark_ips_extension'
require_relative '../../lib/capture_stdout'

class CompareSearchMethods < BaseService
  attr_reader :elastic, :materialized, :solr, :algolia

  def initialize()
    @elastic = GetFacetsSearchResults.new(:elastic)
    @materialized = GetFacetsSearchResults.new(:materialized)
    @solr = GetFacetsSearchResults.new(:solr)
    @algolia = GetFacetsSearchResults.new(:algolia)
    @entries = []
  end

  def call(params:, time:, warmup:)
    compare = run_bench_mark(params, time, warmup)

    compare.entries.each {|d| @entries << d.to_s.strip }
    final_result = Capture.capture do
      compare.run_comparison
    end

    { entries: @entries, result: final_result.stdout, data: compare.data.as_json }
  end

  private

  def run_bench_mark(params, time, warmup)
    Benchmark.ips do |x|
      x.time = time
      x.warmup = warmup
      x.report("ElasticSeach") { @elastic.call(params) }
      x.report("Materialized") { @materialized.call(params) }
      x.report("Solr") { @solr.call(params) }
      x.report("Algolia") { @algolia.call(params) }
      x.compare!
    end
  end
end
