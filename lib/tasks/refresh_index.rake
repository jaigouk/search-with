namespace :search_index do
  desc 'Refresh all indices'
  task refresh: :environment do
    reindex = RefreshRequiredStuffsForSearch.new
    reindex.call
  end
end
