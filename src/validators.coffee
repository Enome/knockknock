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
    @message = 'Your entry didn\'t match the pattern.'

  validate : (observable)->
    value = ko.utils.stringTrim observable()
    value is '' or @rx.test observable()


class Email extends Regex

  constructor : ->
    super /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i
    @message = 'Your entry didn\'t match a valid emailaddress.'


class Number extends Regex

  constructor : ->

    super /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/
    @message = 'Your entry didn\'t match a valid number ( 1 1.0 1,000.00 -1 -1.0 ... )'


class Equals

  constructor : ->
    @message = 'Your entry didn\'t match the other value.'

  validate : (observable, equalee)->
    observable() is equalee()

window.validators =
  Required : Required
  Max      : Max
  Regex    : Regex
  Email    : Email
  Number   : Number
  Equals   : Equals


if module?
  module.exports = window.validators
