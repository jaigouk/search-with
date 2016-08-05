Rails.application.routes.draw do
  root to: "home#index"
  get  "elastic" => "home#elastic"
  get  "elastic_autocomplete" => "home#elastic_autocomplete"
end
