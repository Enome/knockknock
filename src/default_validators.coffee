class Required

  constructor : ->
    @name = 'required'
    @message = 'This field is required'

  validate : (observable)->
    value = ko.utils.stringTrim observable()
    if value? and value isnt ''
      true
    else
      false


class Max

  constructor : ->
    @name = 'max'
    @message = 'Please enter no more than {0} characters.'

  validate : (observable, length)->
    value = ko.utils.stringTrim observable()

    if value.length > length
      false
    else
      true

module.exports =
  Required : Required
  Max : Max
