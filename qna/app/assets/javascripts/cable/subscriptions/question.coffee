App.cable.subscriptions.create('QuestionsChannel', {
  connected: ->
    @follow()

  follow: ->
    @perform 'follow'
  
  received: (data) ->
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $(".questions").append(html)

  createLine: (data) ->
    """
    <p>
      <a href="/questions/#{data["id"]}">#{data["title"]}</a>
    </p>
    """
})