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

    @cache.push
      observable : observable
      validators : validators

    observable.errors = ko.observableArray()
    observable.isValid = ko.dependentObservable ->
      observable.errors().length is 0
    observable.subscribe => @_validate(observable, validators...)
    

  validate : =>

    errors = []

    for item in @cache
      @_validate item.observable, item.validators...
      errors.push item.observable.errors()

    errors = [].concat errors...
    errors.length is 0


  _validate : (observable, validators...)->

      observable.errors.removeAll()

      for validator in validators
        if not validator.validate observable
          observable.errors.push validator.message


if exports?
  exports.Validation = Validation

window.Validation = Validation
