Validation         = require('../src/validation').Validation
default_validators = require '../src/default_validators'


describe 'Validation', ->


  describe 'Default Validators', ->

    it 'should load default validators', ->

      validation = new Validation()
      
      for k, Validator of default_validators
        validator = new Validator
        expect(validation.validators.all()[validator.name]).toBeDefined()



  describe 'Add Rules', ->

    somevalue = null

    describe 'Required', ->

      beforeEach ->
        validation = new Validation()
        somevalue = ko.observable()
        validation.addRules somevalue, required:true


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
          required = new default_validators.Required()

          somevalue ''
          somevalue.errors()[0].should_be required.message


        describe 'Multiple calls to same observable', ->

          it 'should refresh the error list', ->
            somevalue ''
            somevalue 'somevalue'

            somevalue.errors().length.should_be 0


    describe 'Max', ->

      beforeEach ->
        validation = new Validation()
        somevalue = ko.observable()
        validation.addRules somevalue, max:5

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
