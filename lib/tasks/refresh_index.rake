namespace :search_index do
  desc 'Refresh all indices'
  task refresh: :environment do
    MaterializedSearchResult.refresh()
  end
end
