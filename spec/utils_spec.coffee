describe 'Utils', ->


  describe 'removeClass', ->


    it 'should remove the invalid class from className', ->

      element = className:'invalid'
      ko.utils.removeClass element, 'invalid'
      element.className.should_be ''


    it 'should remove the valid class from className', ->

      element = className:'invalid valid'
      ko.utils.removeClass element, 'valid'
      element.className.should_be 'invalid'


    it 'should remove the valid class from many classNames', ->

      element = className:'invalid valid pretty side'
      ko.utils.removeClass element, 'valid'
      element.className.should_be 'invalid pretty side'
