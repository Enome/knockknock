default_validators = require './default_validators'

class Validators
  constructor : ->
    @validators = {}

  add : (validator)->
    @validators[validator.name] = validator

  all : ->
    @validators

exports.Validators = Validators
