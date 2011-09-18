(function() {
  var Max, Required;
  Required = (function() {
    function Required() {
      this.message = 'This field is required.';
    }
    Required.prototype.validate = function(observable) {
      var value;
      value = ko.utils.stringTrim(observable());
      return (value != null) && value !== '';
    };
    return Required;
  })();
  Max = (function() {
    function Max(length) {
      this.length = length;
      this.message = "Please enter no more than " + this.length + " character(s).";
    }
    Max.prototype.validate = function(observable) {
      var value;
      value = ko.utils.stringTrim(observable());
      return value.length <= this.length;
    };
    return Max;
  })();
  window.validators = {
    Required: Required,
    Max: Max
  };
  if (typeof module !== "undefined" && module !== null) {
    module.exports = window.validators;
  }
}).call(this);
