jQuery(function() {
  var solr_search_list, getSolrSearchResult;
  $("#solr-search-input").autocomplete({
    source: "/solr_autocomplete",
    minLength: 2
  });
  solr_search_list = [];
  getSolrSearchResult = function(array) {
    var data, i, len, q, query;
    query = $('#solr-search-input').val();
    data = {
      q: query
    };
    for (i = 0, len = array.length; i < len; i++) {
      q = array[i];
      data[q] = "true";
    }
    return $.ajax({
      url: "/solr",
      method: 'GET',
      data: data,
      contentType: "application/vnd.api+json",
      beforeSend: function(xhr) {
        var spinner;
        $('#solr-search-input').val('');
        spinner = '<i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i>';
        $('.spinner').html(spinner);
        return $('.solr-search-result').html("");
      }
    }).done(function(result) {
      var item, j, len1, ref, results;
      $('.spinner').html('');
      ref = result.data;
      results = [];
      for (j = 0, len1 = ref.length; j < len1; j++) {
        item = ref[j];
        results.push($('.solr-search-result').append("<tr> <th scope='row'>" + item.attributes.price + "</th> <td colspan='2'>" + item.attributes.title + "</td> <td >" + item.attributes.options + "</td> <td>" + item.attributes.tags + "</td> </tr>"));
      }
      return results;
    });
  };
  return $('.solr-option').on('change', function() {
    var checkbox;
    checkbox = $(this);
    if (this.checked) {
      solr_search_list.push(checkbox.val());
    } else {
      solr_search_list.pop(checkbox.val());
    }
    getSolrSearchResult(solr_search_list);
    return console.log(solr_search_list);
  });
});
