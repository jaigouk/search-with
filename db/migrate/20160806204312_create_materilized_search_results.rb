class CreateMaterilizedSearchResults < ActiveRecord::Migration
  def change
    create_view :materialized_search_results, materialized: true
  end
end
