class Required

  constructor : ->
    @message = 'This field is required.'

  validate : (observable)->
    value = ko.utils.stringTrim observable()
    value? and value isnt ''


class Max

  constructor : (@length)->
    @message = "Please enter no more than #{@length} character(s)."

  validate : (observable)->
    value = ko.utils.stringTrim observable()
    value.length <= @length


window.validators =
  Required : Required
  Max : Max

if module?
  module.exports = window.validators
