Validators = require('../src/validators').Validators

describe 'validators', ->

  describe 'Add validator', ->

    it 'should add validator', ->

      validators = new Validators
      somevalidator =
        name     : 'somevalue'
        validate : 'somefunction'

      validators.add somevalidator
      expect(validators.validators.somevalue).toEqual somevalidator
