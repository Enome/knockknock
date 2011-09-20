Validation = require('../src/validation').Validation
validators = require '../src/validators'
Required   = validators.Required
Max        = validators.Max


describe 'Validation', ->

  describe 'Add Validator', ->

    describe 'Validator without options', ->

      somevalue = null

      beforeEach ->
        validation = new Validation()
        somevalue = ko.observable()
        validation.addValidator somevalue, new Required


      describe 'isValid', ->

        it 'should be true with string', ->

          somevalue 'somevalue'
          expect(somevalue.isValid()).toBeTruthy()

        it 'should be false with empty string', ->

          somevalue ''
          expect(somevalue.isValid()).toBeFalsy()


      describe 'Errors', ->

        it 'should have one item', ->

          somevalue ''
          somevalue.errors().length.should_be 1


        it 'should have no errors', ->

          somevalue 'somevalue'
          somevalue.errors().length.should_be 0


        it 'should have the required validator message', ->
          required = new Required()

          somevalue ''
          somevalue.errors()[0].should_be required.message


        describe 'Multiple calls to same observable', ->

          it 'should refresh the error list', ->
            somevalue ''
            somevalue 'somevalue'

            somevalue.errors().length.should_be 0


    describe 'Validator with options', ->

      somevalue = null

      beforeEach ->

        validation = new Validation()
        somevalue = ko.observable()
        validation.addValidator somevalue, new Max 5

      describe 'isValid', ->

        it 'should be true with a string with 5 chars', ->

          somevalue '12345'
          expect(somevalue.isValid()).toBeTruthy()

        it 'should be true with a string with 3 chars', ->

          somevalue '123'
          expect(somevalue.isValid()).toBeTruthy()

        it 'should be false with a string with 6 chars', ->

          somevalue '123456'
          expect(somevalue.isValid()).toBeFalsy()
  

    describe 'Multiple validators', ->

      somevalue = null

      beforeEach ->

        validation = new Validation()
        somevalue = ko.observable()
        validation.addValidator somevalue, new Required, new Max 5

      describe 'isValid', ->

        it 'should be true with a string', ->

          somevalue 'some'
          expect(somevalue.isValid()).toBeTruthy()

        it 'should be false with empty string', ->

          somevalue ''
          expect(somevalue.isValid()).toBeFalsy()

        it 'should be true with a string with 5 chars', ->

          somevalue '12345'
          expect(somevalue.isValid()).toBeTruthy()

        it 'should be true with a string with 3 chars', ->

          somevalue '123'
          expect(somevalue.isValid()).toBeTruthy()

        it 'should be false with a string with 6 chars', ->

          somevalue '123456'
          expect(somevalue.isValid()).toBeFalsy()


    describe 'Global validation', ->

      validation = null
      somevalue = null
      othervalue = null
      required = null
      max = max

      beforeEach ->

        somevalue = ko.observable()
        othervalue = ko.observable()

        validation = new Validation()
        required = new Required
        max = new Max 3

        validation.addValidator somevalue, required
        validation.addValidator othervalue, max


      describe 'cache', ->

        it 'should have 2 items', ->

          validation.cache.length.should_be 2

        it 'should have somevalue as the first observable', ->

          expect(validation.cache[0].observable).toEqual somevalue

        it 'should have required as the first validators', ->

          expect(validation.cache[0].validators).toEqual [required]

        it 'should have othervalue as the second observable', ->

          expect(validation.cache[1].observable).toEqual othervalue

        it 'should have max as the second validators', ->

          expect(validation.cache[1].validators).toEqual [max]


      describe 'validate', ->

        it 'should validate all observables in cache', ->
        
          validation._validate = jasmine.createSpy()
          validation.validate()

          for item in validation.cache
            validation._validate.should_have_been_called_with item.observable, item.validators...
