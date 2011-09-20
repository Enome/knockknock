(function() {
  var Email, Equals, Max, Number, Regex, Required;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
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
  Regex = (function() {
    function Regex(rx) {
      this.rx = rx;
      this.message = 'Your entry didn\'t match the pattern.';
    }
    Regex.prototype.validate = function(observable) {
      var value;
      value = ko.utils.stringTrim(observable());
      return value === '' || this.rx.test(observable());
    };
    return Regex;
  })();
  Email = (function() {
    __extends(Email, Regex);
    function Email() {
      Email.__super__.constructor.call(this, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
      this.message = 'Your entry didn\'t match a valid emailaddress.';
    }
    return Email;
  })();
  Number = (function() {
    __extends(Number, Regex);
    function Number() {
      Number.__super__.constructor.call(this, /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/);
      this.message = 'Your entry didn\'t match a valid number ( 1 1.0 1,000.00 -1 -1.0 ... )';
    }
    return Number;
  })();
  Equals = (function() {
    function Equals(equalee) {
      this.equalee = equalee;
      this.message = 'Your entry didn\'t match the other value.';
    }
    Equals.prototype.validate = function(observable) {
      if (typeof this.equalee === 'function') {
        return observable() === this.equalee();
      } else {
        return observable() === value;
      }
    };
    return Equals;
  })();
  window.validators = {
    Required: Required,
    Max: Max,
    Regex: Regex,
    Email: Email,
    Number: Number,
    Equals: Equals
  };
  if (typeof module !== "undefined" && module !== null) {
    module.exports = window.validators;
  }
}).call(this);
