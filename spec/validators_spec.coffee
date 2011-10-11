validators = kk.validators

Max      = validators.Max
Required = validators.Required
Regex    = validators.Regex
Email    = validators.Email
Number   = validators.Number
Equals   = validators.Equals


describe 'Validators', ->


  describe 'Required', ->


    it 'should be true if value is string', ->

      somevalue = 'Somevalue'
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false if value is empty string', ->
      
      somevalue = ''
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeFalsy()

    it 'should be false if value is a string with spaces', ->
      
      somevalue = '   '
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeFalsy()


    it 'should be true if value is a number', ->
      
      somevalue = 666
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false if value is a undefined', ->
      
      somevalue = undefined
      required = new Required()
      result = required.validate somevalue
      expect(result).toBeFalsy()


    it 'should have the custom validation message', ->

      validator = new Required 'This is a very custom message.'
      validator.message.should_be 'This is a very custom message.'



  describe 'Max', ->


    it 'should be false if value is > 2 chars long', ->

      somevalue = 'somevalue'
      max = new Max 2
      result = max.validate somevalue
      expect(result).toBeFalsy()


    it 'should be true if value is <= 2 chars long', ->

      somevalue = 's'
      max = new Max 2
      result = max.validate somevalue
      expect(result).toBeTruthy()


    it 'should have the correct error message', ->

      max = new Max 2
      max.message.should_be 'Your entry has more than 2 character(s).'


    it 'should be true if value is a number', ->
      
      somevalue = 666
      max = new Max 5
      result = max.validate somevalue
      expect(result).toBeTruthy()


    it 'should be true if value is a undefined', ->
      
      somevalue = undefined
      max = new Max 5
      result = max.validate somevalue
      expect(result).toBeTruthy()


    it 'should have the custom validation message', ->

      validator = new Max 2, 'This is a very custom message.'
      validator.message.should_be 'This is a very custom message.'



  describe 'Regex', ->


    it 'should be true if it matches the regex', ->

      somevalue = 'lucifer/666'
      rx = new Regex /[^/]+\d+/
      result = rx.validate somevalue
      expect(result).toBeTruthy()

    
    it 'should be true if string is empty', ->

      somevalue = ''
      rx = new Regex /[^/]+\d+/
      result = rx.validate somevalue
      expect(result).toBeTruthy()


    it 'should be true if value is a number', ->
      
      somevalue = 666
      rx = new Regex /[^/]+\d+/
      result = rx.validate somevalue
      expect(result).toBeTruthy()


    it 'should be true if value is a undefined', ->
      
      somevalue = undefined
      rx = new Regex /[^/]+\d+/
      result = rx.validate somevalue
      expect(result).toBeTruthy()


    it 'should have the custom validation message', ->

      validator = new Regex /[^/]+\d+/, 'This is a very custom message.'
      validator.message.should_be 'This is a very custom message.'


  describe 'Email', ->


    it 'should be true with a valid email', ->

      somevalue = 'info@enome.be'
      email = new Email
      result = email.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false with an invalid email', ->

      somevalue = 'infoenomebe'
      email = new Email
      result = email.validate somevalue
      expect(result).toBeFalsy()


    it 'should have the custom validation message', ->

      validator = new Email 'This is a very custom message.'
      validator.message.should_be 'This is a very custom message.'


  describe 'Number', ->


    it 'should be true with a valid number: 1 1.0 1,000.00 -1 -1.0 ... ', ->
      
      somevalue = '1.00'
      number = new Number
      result = number.validate somevalue
      expect(result).toBeTruthy()


    it 'should have the custom validation message', ->

      validator = new Number 'This is a very custom message.'
      validator.message.should_be 'This is a very custom message.'


  describe 'Equals', ->


    it 'should be true if both strings are equal', ->
      
      somevalue = 'somevalue'
      othervalue = 'somevalue'

      equals = new Equals othervalue
      result = equals.validate somevalue
      expect(result).toBeTruthy()


    it 'should be true if both integers are equal', ->
      
      somevalue = 1
      equals = new Equals 1
      result = equals.validate somevalue
      expect(result).toBeTruthy()


    it 'should be false if both string are not equal', ->
      
      somevalue = '5'
      equal = new Equals '2'
      result = equal.validate somevalue
      expect(result).toBeFalsy()


    it 'should be call the value if it\'s a function', ->
      
      somevalue = '5'
      othervalue = jasmine.createSpy()
      equal = new Equals othervalue
      result = equal.validate somevalue
      othervalue.should_have_been_called()


    it 'should have the custom validation message', ->

      validator = new Equals {}, 'This is a very custom message.'
      validator.message.should_be 'This is a very custom message.'
