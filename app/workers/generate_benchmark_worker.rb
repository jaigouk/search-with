class GenerateBenchmarkWorker
  include Sidekiq::Worker
  def perform
    params = {q: Activity.first.title.split(' ').first, camp: "false", page: 1, per_page: 5}

    comparison = CompareSearchMethods.new()
    bench_mark_data_param = comparison.call(params: params, time: 10, warmup: 5)

    save_bench_mark_data = SaveBenchMarkData.new()
    save_bench_mark_data.call(bench_mark_data_param)
  end
end
