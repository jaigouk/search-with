namespace :materialized do
  desc 'Refresh materialized_vew'
  task refresh: :environment do
    MaterializedSearchResult.refresh()
  end

  desc 'Generate search suggestions'
  task seed_suggestions: :environment do
    MaterializedSearchSuggestion.seed()
  end

  desc 'Clear search suggestions data'
  task clear_suggestions: :environment do
    MaterializedSearchSuggestion.clear()
  end
end
