jQuery ->

  $("#elastic-search").autocomplete(
    source: "/elastic_autocomplete",
    minLength: 2
  )

  elastic_search_list = []

  getElasticSearchResult = (array) ->
    query = $('#elastic-search-input').val()
    data = {q: query}
    for q in array
      data[q] = "true"
    $.ajax(
      url: "/elastic", method: 'GET', data: JSON.stringify(data),
      contentType: "application/vnd.api+json",
      beforeSend: (xhr) ->
        $('#elastic-search-input').val('')
        spinner = '<i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i>'
        $('.spinner').html(spinner)
        $('.elastic-search-result').html("")
    ).done((result) ->
      $('.spinner').html('')
      console.log result
      for item in result.data
        $('.elastic-search-result').append("
          <tr>
              <th scope='row'>#{item.attributes.price}</th>
              <td colspan='2'>#{item.attributes.title}</td>
              <td>#{item.attributes.tags}</td>
            </tr>
        ")
    )

  $('.elastic-option').on('change', ->
    checkbox = $(this)
    if this.checked
      elastic_search_list.push(checkbox.val())
    else
      elastic_search_list.pop(checkbox.val())
    # console.log("%% after this: #{elastic_search_list.join(', ')}" )
    getElasticSearchResult(elastic_search_list)
    console.log elastic_search_list
  )
