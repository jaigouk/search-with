# README

https://serene-stream-86224.herokuapp.com

* create a very simple app that has some "activity" records with various attributes
* a user should be able to check/uncheck boxes on the left filter panel (and/or, if we have time, to do full-text search)
* activity records on the right activity table update via javascript.

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
- [ ] solr
- [ ] materialized view
- [ ] [Typehead](https://github.com/twitter/typeahead.js/blob/master/doc/jquery_typeahead.md)
