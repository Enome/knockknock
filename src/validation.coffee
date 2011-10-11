class Validation

  constructor : (viewmodel, configuration, alwaysWrite=true)->

    @cache = []

    for key, value of configuration
      viewmodel[key] = kk.observable viewmodel[key], value, alwaysWrite
      @cache.push viewmodel[key]


     @isValid = ko.dependentObservable =>
       for observable in @cache
         if not observable.isValid()
           return false

        true

  validate : ->

    observable.validate() for observable in @cache
      


kk.Validation = Validation
