Max      = require('../src/default_validators').Max
Required = require('../src/default_validators').Required

describe 'Default Validators', ->

  describe 'required', ->

    it 'should be true if observable is string', ->

      somevalue = ko.observable('Somevalue')
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false if observable is empty string', ->
      
      somevalue = ko.observable()
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeFalsy()

    it 'should be false if observable is a string with spaces', ->
      
      somevalue = ko.observable('   ')
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeFalsy()


  describe 'max', ->

    it 'should be false if observable is > 2 chars long', ->

      somevalue = ko.observable('somevalue')
      max = new Max()
      result = max.validate somevalue, 2
      expect(result).toBeFalsy()


    it 'should be true if observable is <= 2 chars long', ->

      somevalue = ko.observable('s')
      max = new Max()
      result = max.validate somevalue, 2
      expect(result).toBeTruthy()
