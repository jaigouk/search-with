jQuery ->
  $("#elastic-search").autocomplete(
    source: "/elastic_autocomplete",
    minLength: 2
  )
