class CreateMaterilizedSearchResults < ActiveRecord::Migration
  def change
    create_view :materilized_search_results, materialized: true
  end
end
