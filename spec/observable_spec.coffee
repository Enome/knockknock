validators = kk.validators
Required   = validators.Required
Email      = validators.Email
Max        = validators.Max

describe 'kk.observable ->', ->


  describe 'Observable ->', ->


    it 'should behave as a normal observable', ->

      somevalue = kk.observable 'somevalue'
      somevalue().should_be 'somevalue'


    it 'should also be able to be dependent on an observable', ->

      othervalue = ko.observable 'othervalue'
      somevalue = kk.observable othervalue
      somevalue().should_be 'othervalue'


  describe 'General tests ->', ->


    it 'should be invalid if value is empty string', ->

      somevalue = kk.observable '', [ new Required, new Email ]
      somevalue ''
      expect(somevalue.isValid()).toBeFalsy()


    it 'should be valid if value is something', ->

      somevalue = kk.observable '', new Required
      somevalue 'somevalue'
      expect(somevalue.isValid()).toBeTruthy()


    it 'should be invalid if value isnt an email', ->

      somevalue = kk.observable '', [ new Required, new Email ]
      somevalue 'some.value'
      expect(somevalue.isValid()).toBeFalsy()


    it 'should be invalid if value is longer than 3 chars', ->

      somevalue = kk.observable '', new Max(3)
      somevalue '12345'
      expect(somevalue.isValid()).toBeFalsy()


  describe 'Error messages ->', ->


    it 'should have one error message', ->

      somevalue = kk.observable '', new Required
      somevalue ''
      somevalue.errors().length.should_be 1

    
    it 'should have two error message', ->

      somevalue = kk.observable '', [ new Max(2), new Email ]
      somevalue 'somevalue'
      somevalue.errors().length.should_be 2


    it 'should reset the error message each time value is updated', ->

      somevalue = kk.observable '', new Required
      somevalue ''
      somevalue 'somevalue'
      somevalue.errors().length.should_be 0


  describe 'Always write ->', ->


    it 'defaults to always write( even if it\'s invalid )', ->

      somevalue = kk.observable '', new Required
      somevalue 'somevalue'
      somevalue ''
      somevalue().should_be ''


    it 'should not write if value is invalid', ->

      somevalue = kk.observable '', new Required, false
      somevalue 'somevalue'
      somevalue ''
      somevalue().should_be 'somevalue'


  describe 'Validate ->', ->


    it 'should ', ->

      somevalue = kk.observable '', new Required, false
      somevalue.errors().length.should_be 0

      somevalue.validate()
      somevalue.errors().length.should_be 1
