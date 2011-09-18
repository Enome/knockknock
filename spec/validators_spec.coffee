Max      = require('../src/validators').Max
Required = require('../src/validators').Required

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
      max = new Max 2
      result = max.validate somevalue
      expect(result).toBeFalsy()


    it 'should be true if observable is <= 2 chars long', ->

      somevalue = ko.observable('s')
      max = new Max 2
      result = max.validate somevalue
      expect(result).toBeTruthy()

    it 'should have the correct error message', ->

      max = new Max 2
      max.message.should_be 'Please enter no more than 2 character(s).'
