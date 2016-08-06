class CreateMaterilizedSearchResults < ActiveRecord::Migration
  def change
    create_view :materilized_search_results
  end
end
