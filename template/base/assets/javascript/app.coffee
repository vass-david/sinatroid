String.prototype.startsWith = (needle) ->
  @indexOf(needle) == 0
String.prototype.includes = (needle) ->
  @indexOf(needle) > -1
Array.prototype.last = ->
  @[@length-1]
HTMLCollection.prototype.last = ->
  @[@length-1]
