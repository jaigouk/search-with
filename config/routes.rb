Rails.application.routes.draw do
  root to: "home#index"
  get  "elastic" => "home#elastic"
  get  "elastic_autocomplete" => "home#elastic_autocomplete"

  get  "solr" => "home#solr"

  get  "algolia" => "home#algolia"

  get  "materialized" => "home#materialized"
  get  "materialized_autocomplete" => "home#materialized_autocomplete"
end
