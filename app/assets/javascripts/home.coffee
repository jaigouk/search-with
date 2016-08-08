jQuery ->
  $('#update-benchmark').on('click', (e) ->
    e.preventDefault()
    $.ajax(
      url: "/benchmark", method: 'GET', data: {}
      contentType: "application/vnd.api+json",
      beforeSend: (xhr) ->
        spinner = '<i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i>'
        $('.landing-spinner').html(spinner)
        $('.benchmark-content').hide().html('')
    ).done((result) ->
      $('.landing-spinner').html('')
      $('.benchmark-content').html("
        <code class='language-bash'>
          #{result.entries[0]}&#13;&#10;
          #{result.entries[1]}&#13;&#10;
          #{result.entries[2]}&#13;&#10;
          &#13;&#10;
          #{result.result}
        </code>
      ").show()
    )
  )
