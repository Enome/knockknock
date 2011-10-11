kk.getErrorMessages = (validators, value)->

  validator.message \
  for validator in validators \
  when not validator.validate value


ko.dependentObservable.fn.validate = ()-> @_validate @()


kk.observable = (observable, validators, alwaysWrite=true)->

  if not ko.isObservable observable
    observable = ko.observable observable

  if not kk.utils.isArray validators
    validators = [ validators ]

  errors = ko.observableArray()
  isValid = ko.dependentObservable -> errors().length is 0
  _validate = (value)->
    errors kk.getErrorMessages validators, value

  interceptor = ko.dependentObservable
    read : observable
    write : (value)->
      _validate(value)

      if alwaysWrite
        observable value
      else if interceptor.isValid()
        observable value

  interceptor.errors    = errors
  interceptor.isValid   = isValid
  interceptor._validate = _validate
  interceptor
