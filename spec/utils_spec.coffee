describe 'Utils', ->


  describe 'removeClass', ->


    it 'should remove the invalid class from className', ->

      element = className:'invalid'
      kk.utils.removeClass element, 'invalid'
      element.className.should_be ''


    it 'should remove the valid class from className', ->

      element = className:'invalid valid'
      kk.utils.removeClass element, 'valid'
      element.className.should_be 'invalid'


    it 'should remove the valid class from many classNames', ->

      element = className:'invalid valid pretty side'
      kk.utils.removeClass element, 'valid'
      element.className.should_be 'invalid pretty side'
