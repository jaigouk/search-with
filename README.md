# README

[![build status](https://gitlab.com/jaigouk/search-with/badges/master/build.svg)](https://gitlab.com/jaigouk/search-with/commits/master)
[![Code Climate](https://codeclimate.com/repos/57a3fd27803a5f0084000c6a/badges/700cc6c590402e6b21af/gpa.svg)](https://codeclimate.com/repos/57a3fd27803a5f0084000c6a/feed)

https://search-with.herokuapp.com

* create a very simple app that has some "activity" records with various attributes
* a user should be able to check/uncheck boxes on the left filter panel (and/or, if we have time, to do full-text search)
* activity records on the right activity table update via javascript.
* benchmarking data for using famous search methods

# setup

```
bundle install
rake db:setup
rake db:seed
rails server
```

# deploy

```
git add .
git commit -m "updated..."
git push heroku master

heroku run rake db:migrate
heroku run rake db:seed
heroku run rake searchkick:reindex:all
```

# todo

- [x] relationships
- [x] db:seed
- [x] bootstrap 4
- [x] elastic search 
- [ ] facets with js
- [ ] setup benchmarking
- [ ] [algolia](https://www.algolia.com)
- [ ] [materialized view](http://confreaks.tv/videos/railsconf2016-multi-table-full-text-search-with-postgres)
- [ ] solr & sunspot
- [ ] add some results on the landing page with descriptions
- [ ] [Typehead](https://github.com/twitter/typeahead.js/blob/master/doc/jquery_typeahead.md)
