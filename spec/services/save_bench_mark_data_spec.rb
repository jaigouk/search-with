require 'spec_helper'

RSpec.describe SaveBenchMarkData do
  let(:entries_array) do
    ["        ElasticSeach    163.118  i/s (6.131ms) -    810.000  in   5.043767s",
 "   Materialized View    139.508  i/s (7.168ms) -    700.000  in   5.055447s"]
  end

  let(:result_text) do
    "\nComparison:\n        ElasticSeach:      163.1 i/s (6.131ms)\n   Materialized View:      139.5 i/s (7.168ms) - 1.17x slower\n\n"
  end

  let(:data) do
    [{"name"=>"ElasticSeach",
      "ips"=>163.39093704431707,
      "stddev"=>15,
      "microseconds"=>5003946.792892456,
      "iterations"=>810,
      "cycles"=>15},
     {"name"=>"Materialized View",
      "ips"=>135.078677770012,
      "stddev"=>12,
      "microseconds"=>5049356.42300415,
      "iterations"=>676,
      "cycles"=>13}]
  end

  let(:params) do
    {entries: entries_array, result: result_text, data: data}
  end

  before(:all) do
    populate_5_activities_1
    MaterializedSearchResult.refresh

    @save_bench_mark_data = SaveBenchMarkData.new()
  end


  describe 'self.call' do
    it 'saves benchmarking results' do
      expect do
        @save_bench_mark_data.call(params)
      end.to change(BenchMarkData, :count).by(1)
    end

    it 'sanized results' do
      @save_bench_mark_data.call(params)
      benchmark_data = BenchMarkData.last
      expect(benchmark_data.entries.size).to eq 2
      expect(benchmark_data.result.include?('Comparison:')).to be_truthy
      expect(benchmark_data.data.size).to eq 2
    end
  end
end
