# Benchmarking Search Options for Rails 5

[![travis](https://img.shields.io/travis/jaigouk/search-with.svg)](https://travis-ci.org/jaigouk/search-with)
[![codebeat badge](https://codebeat.co/badges/8bb5880c-5ccf-456a-98cf-dbe65b722a95)](https://codebeat.co/projects/github-com-jaigouk-search-with)
[![codacy badge](https://img.shields.io/codacy/grade/646e5d50e84d4f97ada49a381ba61d16.svg)](https://www.codacy.com/app/jaigouk/search-with)
[![codacy coverage badge](https://img.shields.io/codacy/coverage/646e5d50e84d4f97ada49a381ba61d16.svg)](www.codacy.com/app/jaigouk/search-with)

https://search-with.jaigouk.com

* create a very simple app that has some "activity" records with various attributes
* a user should be able to check/uncheck boxes on the left filter panel (and/or, if we have time, to do full-text search)
* activity records on the right activity table update via javascript.
* benchmarking data for using famous search methods

# setup

```bash
bundle install
bin/rails db:setup
bin/rails db:seed
bin/rails search_index:refresh
rails server
```


# deploy

```bash
git add .
git commit -m "updated..."
git push heroku master

heroku run rake db:migrate
heroku run rake db:seed
heroku run rake search_index:refresh
heroku run rake materialized:clear_suggestions
heroku run rake materialized:seed_suggestions
```

# Generating benchmark data (console for now)

click `Update the result` button in the bottom of landing page. 
it will run sidekiq background job. Wait and visit again. 

# todo

- [x] relationships
- [x] db:seed
- [x] bootstrap 4
- [x] elastic search 
- [x] facets with js
- [x] setup benchmarking
- [x] [materialized view](http://confreaks.tv/videos/railsconf2016-multi-table-full-text-search-with-postgres)
- [x] add some results on the landing page with descriptions
- [x] [algolia](https://www.algolia.com)


# Etc

`rails generate scenic:model recent_status --materialized`

https://github.com/pires/kubernetes-elasticsearch-cluster
https://github.com/mosuka/kubernetes-solr/tree/master/5.5
