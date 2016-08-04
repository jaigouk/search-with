Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get  "elastic" => "home#elastic"
  get  "elastic_autocomplete" => "home#elastic_autocomplete"
end
