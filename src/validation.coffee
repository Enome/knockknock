Validators = require('./validators').Validators
default_validators = require './default_validators'

class Validation

  constructor : ->
    @validators = new Validators
    @loadDefaultValidators()


  loadDefaultValidators : ->

    for k, Validator of default_validators
      validator = new Validator
      @validators.add validator


  addRules : (observable, rules)->

    observable.errors = ko.observableArray()
    observable.isValid = ko.dependentObservable ->
      observable.errors().length is 0
    observable.subscribe => @subscription(observable, rules)
    

  subscription : (observable, rules)->

      observable.errors.removeAll()
      for ruleKey, rule of rules
        for validatorKey, validator of @validators.all()
          if ruleKey is validatorKey and not validator.validate observable, rule
            observable.errors.push validator.message


exports.Validation = Validation
