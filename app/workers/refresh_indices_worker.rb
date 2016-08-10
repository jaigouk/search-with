class RefreshIndicesWorker
  include Sidekiq::Worker
  def perform
    refresh = RefreshRequiredStuffsForSearch.new
    refresh.call
  end
end
