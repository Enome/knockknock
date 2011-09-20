describe 'Custom bindings', ->

  describe 'validateCss', ->

    describe 'init', ->

      it 'should add invalid if observable isn\'t valid', ->

        element = {}
        valueAccessor = -> ko.observable()
