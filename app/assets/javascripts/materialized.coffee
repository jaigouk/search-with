jQuery ->
  materialized_search_list = []

  getMaterializedScopeResult = (array) ->
    query = $('#materialized-search-input').val()

    if $('#materialized-search-label').data('next') && ($('#materialized-search-label').data('keyword') == query)
      page = $('#materialized-search-label').data('next')
    else
      page = 1

    data = {q: query, page: page}
    for q in array
      data[q] = "true"

    $.ajax(
      url: "/materialized", method: 'GET', data: data,
      contentType: "application/vnd.api+json",
      beforeSend: (xhr) ->
        $('#materialized-search-input').val('')
        spinner = '<i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i>'
        $('.spinner').html(spinner)
        $('.materialized-search-result').html("")
    ).done((result) ->
      $('.spinner').html('')
      if page is 1
        $('.search-result').replaceWith("
          <div class='card-columns search-result'>
          </div>"
        )
      console.log result.data
      # $('#materialized-search-label').replaceWith("
      #   <div id='materialized-search-label'
      #    data-keyword='#{query}'
      #    data-total='#{result.meta['total-count']}'
      #    data-current='#{result.meta['current-page']}'
      #    data-next='#{result.meta['next-page']}'
      #    data-total-pages='#{result.meta['total-pages']}'>
      #   </div>"
      # )
      for item  in result.data
        $('.materialized-search-result').append("
          <tr>
            <th scope='row'>#{item.attributes.price}</th>
            <td colspan='2'>#{item.attributes.title}</td>
            <td >#{item.attributes.options}</td>
            <td>#{item.attributes.tags}</td>
          </tr>"
        )
    )


  searchReady = ->

    getMaterializedScopeResult(['camp'])

    $('form').submit (e) ->
      e.preventDefault()
      getMaterializedScopeResult(materialized_search_list)
      return false

    $('.materialized-option').on('change', ->
      checkbox = $(this)
      if this.checked
        materialized_search_list.push(checkbox.val())
      else
        materialized_search_list.pop(checkbox.val())
      # console.log("%% after this: #{materialized_search_list.join(', ')}" )
      getMaterializedScopeResult(materialized_search_list)
    )

    queryBox = $('#materialized-search-input')
    if queryBox.length
      queryBox.autocomplete
        source: '/materialized_autocomplete'
        minLength: 2
        select: (event, ui) ->
          queryBox.val ui.item.value
          event.preventDefault()
          getMaterializedScopeResult(ui.item.value)


    # end of searchReady
    return
  searchReady()

