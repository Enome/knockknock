Max      = require('../src/validators').Max
Required = require('../src/validators').Required
Regex    = require('../src/validators').Regex
Email    = require('../src/validators').Email
Number   = require('../src/validators').Number
Equals   = require('../src/validators').Equals


describe 'Validators', ->


  describe 'Required', ->


    it 'should be true if observable is string', ->

      somevalue = ko.observable 'Somevalue'
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false if observable is empty string', ->
      
      somevalue = ko.observable()
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeFalsy()

    it 'should be false if observable is a string with spaces', ->
      
      somevalue = ko.observable '   '
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeFalsy()


  describe 'Max', ->


    it 'should be false if observable is > 2 chars long', ->

      somevalue = ko.observable 'somevalue'
      max = new Max 2
      result = max.validate somevalue
      expect(result).toBeFalsy()


    it 'should be true if observable is <= 2 chars long', ->

      somevalue = ko.observable 's'
      max = new Max 2
      result = max.validate somevalue
      expect(result).toBeTruthy()

    it 'should have the correct error message', ->

      max = new Max 2
      max.message.should_be 'Please enter no more than 2 character(s).'


  describe 'Regex', ->


    it 'should be true if it matches the regex', ->

      somevalue = ko.observable 'lucifer/666'
      rx = new Regex /[^/]+\d+/
      result = rx.validate somevalue
      expect(result).toBeTruthy()

    
    it 'should be true if string is empty', ->

      somevalue = ko.observable('')
      rx = new Regex /[^/]+\d+/
      result = rx.validate somevalue
      expect(result).toBeTruthy()


  describe 'Email', ->


    it 'should be true with a valid email', ->

      somevalue = ko.observable 'info@enome.be'
      email = new Email
      result = email.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false with an invalid email', ->

      somevalue = ko.observable 'infoenomebe'
      email = new Email
      result = email.validate somevalue
      expect(result).toBeFalsy()


  describe 'Number', ->


    it 'should be true with a valid number: 1 1.0 1,000.00 -1 -1.0 ... ', ->
      
      somevalue = ko.observable '1.00'
      number = new Number
      result = number.validate somevalue
      expect(result).toBeTruthy()


  describe 'Equals', ->


    it 'should be true if both strings are equal', ->
      
      somevalue = ko.observable 'somevalue'
      othervalue = ko.observable 'somevalue'

      equals = new Equals othervalue
      result = equals.validate somevalue
      expect(result).toBeTruthy()


    it 'should be true if both integers are equal', ->
      
      somevalue = ko.observable 1
      equals = new Equals 1
      result = equals.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false if both string are not equal', ->
      
      somevalue = ko.observable '5'
      equal = new Equals '2'
      result = equal.validate somevalue
      expect(result).toBeFalsy()


    it 'should be call the value if it\'s a function', ->
      
      somevalue = ko.observable '5'
      othervalue = jasmine.createSpy()
      equal = new Equals othervalue
      result = equal.validate somevalue
      othervalue.should_have_been_called()
