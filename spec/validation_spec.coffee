Validation = kk.Validation
validators = kk.validators

Max      = validators.Max
Required = validators.Required
Email    = validators.Email


describe 'Validation ->', ->


  vm = _vm = config = validation = null

  beforeEach ->

    _vm =
      somevalue : ko.observable()
      othervalue : ko.observable()

    vm =
      somevalue : _vm.somevalue
      othervalue : _vm.othervalue

    config =
      somevalue : new Required
      othervalue : [ new Email, new Max(15) ]



  describe 'Configuration ->', ->


    kkobservable = null

    beforeEach -> 

      kkobservable = isValid : ->
      spyOn(kk, 'observable').andReturn kkobservable


    it 'should replace the observables with kk.observables that are in the configuration' , ->

      validation = new Validation vm, config
      expect(vm.somevalue).toEqual kkobservable
      expect(vm.othervalue).toEqual kkobservable


    it 'should create observables with the settings from the configuration', ->

      validation = new Validation vm, config

      for key, value of config
        kk.observable.should_have_been_called_with _vm[key], value, true


  describe 'isValid ->', ->
    

    it 'should be invalid when somevalue is empty', ->

      validation = new Validation vm, config
      vm.somevalue ''
      vm.othervalue 'othervalue'
      expect(validation.isValid()).toBeFalsy()


    it 'should be valid when both observables have a value', ->

      validation = new Validation vm, config
      vm.somevalue 'somevalue'
      vm.othervalue 'g@g.com'
      expect(validation.isValid()).toBeTruthy()
