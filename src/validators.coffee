class Required

  constructor : (message)->
    @message = message or 'This field is required.'

  validate : (value)->

    if typeof value is 'number'
      return true

    value = ko.utils.stringTrim value
    value? and value isnt ''


class Max

  constructor : (@length, message)->
    @message = message or "Your entry has more than #{@length} character(s)."

  validate : (value)->

    value = ko.utils.stringTrim value?.toString()
    value.length <= @length


class Regex

  constructor : (@rx, message)->
    @message = message or 'Your entry didn\'t match the pattern.'

  validate : (value)->

    value = ko.utils.stringTrim value?.toString()
    value is '' or @rx.test value


class Email extends Regex

  constructor : (message)->
    super /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i
    @message = message or 'Your entry didn\'t match a valid email address.'


class Number extends Regex

  constructor : (message)->

    super /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/
    @message = message or 'Your entry didn\'t match a valid number ( 1 1.0 1,000.00 -1 -1.0 ... )'


class Equals

  constructor : (@equalee, message)->
    @message = message or 'Your entry didn\'t match the other value.'

  validate : (value)->
    if typeof @equalee is 'function'
      value is @equalee()
    else
      value is @equalee


kk.validators =
  Required : Required
  Max      : Max
  Regex    : Regex
  Email    : Email
  Number   : Number
  Equals   : Equals
