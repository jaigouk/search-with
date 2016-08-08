# Benchmarking Search Options for Rails 5

[![CircleCI](https://img.shields.io/circleci/project/jaigouk/search-with.svg)](https://circleci.com/gh/jaigouk/search-with)
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
rake db:setup
rake db:seed
bundle exec rake sunspot:solr:start
rails server
```


# deploy

```bash
git add .
git commit -m "updated..."
git push heroku master

heroku run rake db:migrate
heroku run rake db:seed
heroku run rake searchkick:reindex:all
heroku run rake materialized:refresh
heroku run rake materialized:clear_suggestions
heroku run rake materialized:seed_suggestions
```

# Generating benchmark data (console for now)

```ruby
params = {q: "Bubbles", camp: "false", page: 1, per_page: 5}

comparison = CompareSearchMethods.new()
bench_mark_data_param = comparison.call(params: params, time: 5, warmup: 2)

save_bench_mark_data = SaveBenchMarkData.new()
save_bench_mark_data.call(bench_mark_data_param)
```


# todo

- [x] relationships
- [x] db:seed
- [x] bootstrap 4
- [x] elastic search 
- [x] facets with js
- [x] setup benchmarking
- [x] [materialized view](http://confreaks.tv/videos/railsconf2016-multi-table-full-text-search-with-postgres)
- [x] add some results on the landing page with descriptions

- [ ] make save_bench_mark_data to accept params like `elastic vs solr`
- [ ] show memory info
- [ ] [algolia](https://www.algolia.com)
- [ ] solr & sunspot
- [ ] use [dry-rb](http://dry-rb.org/)
- [ ] reactfy (also fix pagination)

# Etc

`rails generate scenic:model recent_status --materialized`

