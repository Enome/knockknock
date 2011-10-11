ko.bindingHandlers.validateCss =
  init : (element, valueAccessor)->
    observable = valueAccessor()

    kk.utils.removeClass element, 'valid'
    kk.utils.removeClass element, 'invalid'

    if observable.isValid()
      element.className = ko.utils.stringTrim(element.className += ' valid')
    else
      element.className = ko.utils.stringTrim(element.className += ' invalid')

  update : (args...)->
    ko.bindingHandlers.validateCss.init args...
