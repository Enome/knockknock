var Email, Equals, Max, Number, Regex, Required, Validation;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
}, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __slice = Array.prototype.slice;
Required = (function() {
  function Required(message) {
    this.message = message || 'This field is required.';
  }
  Required.prototype.validate = function(observable) {
    var value;
    value = ko.utils.stringTrim(observable());
    return (value != null) && value !== '';
  };
  return Required;
})();
Max = (function() {
  function Max(length, message) {
    this.length = length;
    this.message = message || ("Please enter no more than " + this.length + " character(s).");
  }
  Max.prototype.validate = function(observable) {
    var value;
    value = ko.utils.stringTrim(observable());
    return value.length <= this.length;
  };
  return Max;
})();
Regex = (function() {
  function Regex(rx, message) {
    this.rx = rx;
    this.message = message || 'Your entry didn\'t match the pattern.';
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
  function Email(message) {
    Email.__super__.constructor.call(this, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    this.message = message || 'Your entry didn\'t match a valid email address.';
  }
  return Email;
})();
Number = (function() {
  __extends(Number, Regex);
  function Number(message) {
    Number.__super__.constructor.call(this, /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/);
    this.message = message || 'Your entry didn\'t match a valid number ( 1 1.0 1,000.00 -1 -1.0 ... )';
  }
  return Number;
})();
Equals = (function() {
  function Equals(equalee, message) {
    this.equalee = equalee;
    this.message = message || 'Your entry didn\'t match the other value.';
  }
  Equals.prototype.validate = function(observable) {
    if (typeof this.equalee === 'function') {
      return observable() === this.equalee();
    } else {
      return observable() === this.equalee;
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
ko.utils.removeClass = function(element, className) {
  var regex;
  regex = new RegExp("(?:^|\\s)" + className + "(?!\\S)");
  return element.className = element.className.replace(regex, '');
};
ko.utils.isArray = function(obj) {
  return Object.prototype.toString.call(obj) === '[object Array]';
};
Validation = (function() {
  function Validation(configuration, viewmodel) {
    this.validate = __bind(this.validate, this);
    var key, settings;
    this.cache = [];
    if (configuration != null) {
      for (key in configuration) {
        settings = configuration[key];
        if (!ko.utils.isArray(configuration[key])) {
          this.addValidators(viewmodel[key], configuration[key]);
        } else {
          this.addValidators.apply(this, [viewmodel[key]].concat(__slice.call(configuration[key])));
        }
      }
    }
  }
  Validation.prototype.addValidators = function() {
    var observable, validators;
    observable = arguments[0], validators = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    this.cache.push({
      observable: observable,
      validators: validators
    });
    observable.errors = ko.observableArray();
    observable.isValid = ko.dependentObservable(function() {
      return observable.errors().length === 0;
    });
    return observable.subscribe(__bind(function() {
      return this._validate.apply(this, [observable].concat(__slice.call(validators)));
    }, this));
  };
  Validation.prototype.validate = function() {
    var errors, item, _i, _len, _ref, _ref2;
    errors = [];
    _ref = this.cache;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      this._validate.apply(this, [item.observable].concat(__slice.call(item.validators)));
      errors.push(item.observable.errors());
    }
    errors = (_ref2 = []).concat.apply(_ref2, errors);
    return errors.length === 0;
  };
  Validation.prototype._validate = function() {
    var observable, validator, validators, _i, _len, _results;
    observable = arguments[0], validators = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    observable.errors.removeAll();
    _results = [];
    for (_i = 0, _len = validators.length; _i < _len; _i++) {
      validator = validators[_i];
      _results.push(!validator.validate(observable) ? observable.errors.push(validator.message) : void 0);
    }
    return _results;
  };
  return Validation;
})();
if (typeof exports !== "undefined" && exports !== null) {
  exports.Validation = Validation;
}
window.Validation = Validation;
ko.bindingHandlers.validateCss = {
  init: function(element, valueAccessor) {
    var observable;
    observable = valueAccessor();
    ko.utils.removeClass(element, 'valid');
    ko.utils.removeClass(element, 'invalid');
    if (observable.isValid()) {
      return element.className = ko.utils.stringTrim(element.className += ' valid');
    } else {
      return element.className = ko.utils.stringTrim(element.className += ' invalid');
    }
  },
  update: function() {
    var args, _ref;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return (_ref = ko.bindingHandlers.validateCss).init.apply(_ref, args);
  }
};