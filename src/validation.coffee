class Validation

  constructor : (configuration, viewmodel)->

    @cache = []

    if configuration?
      for key, settings of configuration

        observable = viewmodel[key]

        if not ko.utils.isArray configuration[key]
          interceptor = @addValidators observable, configuration[key]

        else
          interceptor = @addValidators observable, configuration[key]...

        viewmodel[key] = interceptor


  addValidators : (observable, validators...)->

    errors = ko.observableArray()
    isValid = ko.dependentObservable -> errors().length is 0
    validate = (validators, value)=> errors @runValidators validators, value

    interceptor = ko.dependentObservable
      read : observable
      write : (value)=>

        interceptor.validate validators, value

        if isValid()
          observable value


    @cache.push
      observable : interceptor
      validators : validators

    interceptor.errors   = errors
    interceptor.isValid  = isValid
    interceptor.validate = validate
      
    interceptor


  runValidators : (validators, value)->

    validator.message \
    for validator in validators \
    when not validator.validate value


  validate : =>

    item.observable.validate(item.validators, item.observable()) for item in @cache

    errors = ( @runValidators item.validators, item.observable() \
               for item in @cache )

    errors = [].concat errors...
    errors.length is 0


kk.Validation = Validation
