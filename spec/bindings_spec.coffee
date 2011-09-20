describe 'Custom bindings', ->

  describe 'validateCss', ->

    describe 'init', ->

      it 'should add invalid if observable isn\'t valid', ->

        element = className:''
        valueAccessor = ->
          o =
            isValid : -> false

        ko.bindingHandlers.validateCss.init element, valueAccessor
        element.className.should_be 'invalid'
        console.log element.className

      it 'should add valid if observable is valid', ->

        element = className:''
        valueAccessor = ->
          o =
            isValid : -> true

        ko.bindingHandlers.validateCss.init element, valueAccessor
        element.className.should_be 'valid'
        console.log element.className

      it 'should remove invalid and add valid if observable is valid and keep all other classes', ->

        element = className:' invalid pretty flowers'
        valueAccessor = ->
          o =
            isValid : -> true

        ko.bindingHandlers.validateCss.init element, valueAccessor
        element.className.should_be 'pretty flowers valid'
