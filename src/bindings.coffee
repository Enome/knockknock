ko.bindingHandlers.validateCss =
  init : (element, valueAccessor)->
    observable = valueAccessor()

    ko.utils.removeClass element, 'valid'
    ko.utils.removeClass element, 'invalid'

    if observable.isValid()
      element.className = ko.utils.stringTrim(element.className += ' valid')
    else
      element.className = ko.utils.stringTrim(element.className += ' invalid')
