(function() {
  var Email, Max, Regex, Required;
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
      return (value != null) || this.rx.test(value);
    };
    return Regex;
  })();
  Email = (function() {
    __extends(Email, Regex);
    function Email() {
      Email.__super__.constructor.call(this, /test/);
      this.message = 'Your entry didn\'t match a valid emailaddress.';
    }
    return Email;
  })();
  window.validators = {
    Required: Required,
    Max: Max,
    Regex: Regex
  };
  if (typeof module !== "undefined" && module !== null) {
    module.exports = window.validators;
  }
}).call(this);
