class Validation

  constructor : ->

    @cache = []


  addValidators : (observable, validators...)->

    @cache.push
      observable : observable
      validators : validators

    observable.errors = ko.observableArray()
    observable.isValid = ko.dependentObservable ->
      observable.errors().length is 0
    observable.subscribe => @_validate(observable, validators...)
    

  _validate : (observable, validators...)->

      observable.errors.removeAll()

      for validator in validators
        if not validator.validate observable
          observable.errors.push validator.message

  validate : =>

    for item in @cache
      @_validate item.observable, item.validators...

if exports?
  exports.Validation = Validation

window.Validation = Validation
