App.room = App.cable.subscriptions.create "ReloadNewFeedsChannel",
  received: (data) ->
            $('.render-feed').html(data.html);
