##
# Restaurant namespace
window.Restaurant ?=
  init: ->

##
# Bootstrap code
(($, undefined_) ->
  $ ->
    try
      $body = $('body')
      controller = $body.data('js-controller').replace(/\-/g, '_') + '_controller'
      action = $body.data('js-action').replace(/\-/g, '_')
      activeController = Restaurant[controller]
      Restaurant.init() if $.isFunction(Restaurant.init)
      if activeController?
        activeController.init() if $.isFunction(activeController.init)
        activeController[action]() if $.isFunction(activeController[action])
    catch e
      console.log "App initialization error:" + e.message
) jQuery