class Validation

  constructor : (configuration, viewmodel)->

    @cache = []

    if configuration?
      for key, settings of configuration

        if not ko.utils.isArray configuration[key]
          @addValidators viewmodel[key], configuration[key]

        else
          @addValidators viewmodel[key], configuration[key]...


  addValidators : (observable, validators...)->

    errors = ko.observableArray()
    isValid = ko.dependentObservable ->
      errors().length is 0

    interceptor = ko.dependentObservable
      read : observable
      write : (value)->

        errors.removeAll()
        observable value


    @cache.push
      observable : interceptor
      validators : validators

    interceptor.errors = ko.observableArray()
    interceptor.isValid = ko.dependentObservable ->
      interceptor.errors().length is 0
    interceptor.subscribe => @_validate(interceptor, validators...)

    interceptor
    

  _validate : (observable, validators...)->

      observable.errors.removeAll()

      for validator in validators
        if not validator.validate observable
          observable.errors.push validator.message


  validate : =>

    errors = []

    for item in @cache
      @_validate item.observable, item.validators...
      errors.push item.observable.errors()

    errors = [].concat errors...
    errors.length is 0


if exports?
  exports.Validation = Validation

window.Validation = Validation
