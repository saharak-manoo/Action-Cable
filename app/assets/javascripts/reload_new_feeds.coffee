App.room = App.cable.subscriptions.create "ReloadNewFeedsChannel",
  received: (data) ->

