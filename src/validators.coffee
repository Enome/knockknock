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


class Regex

  constructor : (@rx)->
    @message = 'Your entry didn\'t match the pattern'

  validate : (observable)->
    value = ko.utils.stringTrim observable()
    value? or @rx.test value


window.validators =
  Required : Required
  Max      : Max
  Regex    : Regex

if module?
  module.exports = window.validators
