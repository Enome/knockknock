Validation = kk.Validation
validators = kk.validators

Max      = validators.Max
Required = validators.Required
Email    = validators.Email


describe 'Validation', ->

  describe 'Add Validators', ->

    describe 'Validators without options', ->

      somevalue = null

      beforeEach ->
        validation = new Validation()
        somevalue = validation.addValidators ko.observable(), new Required


      describe 'isValid', ->

        it 'should be true with string', ->

          somevalue 'somevalue'
          expect(somevalue.isValid()).toBeTruthy()

        it 'should be false with empty string', ->

          somevalue ''
          expect(somevalue.isValid()).toBeFalsy()


      describe 'Write to observable', ->

        it 'should not change the observable if it\'s not valid', ->

          somevalue 'some value'
          somevalue ''
          somevalue().should_be 'some value'


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


    describe 'Validators with options', ->


      somevalue = null

      beforeEach ->

        validation = new Validation()
        somevalue = validation.addValidators ko.observable(), new Max 5


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
        somevalue = validation.addValidators ko.observable(), new Required, new Max 5


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

        validation = new Validation()
        required = new Required
        max = new Max 3

        somevalue = validation.addValidators ko.observable(), required
        othervalue = validation.addValidators ko.observable(), max


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
        
          validation.runValidators = jasmine.createSpy()
          validation.validate()

          for item in validation.cache
            validation.runValidators.should_have_been_called_with \
            item.validators, item.observable()


        it 'should return true', ->

          somevalue 'somevalue'
          othervalue '123'
          expect(validation.validate()).toBeTruthy()


        it 'should return false', ->
          somevalue ''
          othervalue '1234'
          expect(validation.validate()).toBeFalsy()


  describe 'Setup configuration with constructor', ->


    describe 'Process configuration', ->

      observable   = ko.observable()
      configMulti  = null
      configSingle = null
      viewmodel    = null


      beforeEach ->
        spyOn(Validation.prototype, 'addValidators').andReturn 'interceptor'

        viewmodel    = somevalue : observable
        configSingle = somevalue : new Required
        configMulti  = somevalue : [ new Required, new Email ]


      it 'should add many validators to somevalue observable', ->

        validation = new Validation configMulti, viewmodel
        validation.addValidators.should_have_been_called_with \
        observable, configMulti.somevalue...


      it 'should add one validator to othervalue observable', ->

        validation = new Validation configSingle, viewmodel
        validation.addValidators.should_have_been_called_with \
        observable, configSingle.somevalue


      it 'should replace the observable with the interceptor if there is many validators', ->

        validation = new Validation configMulti, viewmodel
        viewmodel.somevalue.should_be 'interceptor'

      it 'should replace the observable with the interceptor if there is one validator', ->

        validation = new Validation configMulti, viewmodel
        viewmodel.somevalue.should_be 'interceptor'
