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
  Required.prototype.validate = function(value) {
    if (typeof value === 'number') {
      return true;
    }
    value = ko.utils.stringTrim(value);
    return (value != null) && value !== '';
  };
  return Required;
})();
Max = (function() {
  function Max(length, message) {
    this.length = length;
    this.message = message || ("Please enter no more than " + this.length + " character(s).");
  }
  Max.prototype.validate = function(value) {
    value = ko.utils.stringTrim(value != null ? value.toString() : void 0);
    return value.length <= this.length;
  };
  return Max;
})();
Regex = (function() {
  function Regex(rx, message) {
    this.rx = rx;
    this.message = message || 'Your entry didn\'t match the pattern.';
  }
  Regex.prototype.validate = function(value) {
    value = ko.utils.stringTrim(value != null ? value.toString() : void 0);
    return value === '' || this.rx.test(value);
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
  Equals.prototype.validate = function(value) {
    if (typeof this.equalee === 'function') {
      return value === this.equalee();
    } else {
      return value === this.equalee;
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
    var interceptor, key, observable, settings;
    this.cache = [];
    if (configuration != null) {
      for (key in configuration) {
        settings = configuration[key];
        observable = viewmodel[key];
        if (!ko.utils.isArray(configuration[key])) {
          interceptor = this.addValidators(observable, configuration[key]);
        } else {
          interceptor = this.addValidators.apply(this, [observable].concat(__slice.call(configuration[key])));
        }
        viewmodel[key] = interceptor;
      }
    }
  }
  Validation.prototype.addValidators = function() {
    var errors, interceptor, isValid, observable, validate, validators;
    observable = arguments[0], validators = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    errors = ko.observableArray();
    isValid = ko.dependentObservable(function() {
      return errors().length === 0;
    });
    validate = __bind(function(validators, value) {
      return errors(this.runValidators(validators, value));
    }, this);
    interceptor = ko.dependentObservable({
      read: observable,
      write: __bind(function(value) {
        interceptor.validate(validators, value);
        if (isValid()) {
          return observable(value);
        }
      }, this)
    });
    this.cache.push({
      observable: interceptor,
      validators: validators
    });
    interceptor.errors = errors;
    interceptor.isValid = isValid;
    interceptor.validate = validate;
    return interceptor;
  };
  Validation.prototype.runValidators = function(validators, value) {
    var validator, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = validators.length; _i < _len; _i++) {
      validator = validators[_i];
      if (!validator.validate(value)) {
        _results.push(validator.message);
      }
    }
    return _results;
  };
  Validation.prototype.validate = function() {
    var errors, item, _i, _len, _ref, _ref2;
    _ref = this.cache;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      item.observable.validate(item.validators, item.observable());
    }
    errors = (function() {
      var _j, _len2, _ref2, _results;
      _ref2 = this.cache;
      _results = [];
      for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
        item = _ref2[_j];
        _results.push(this.runValidators(item.validators, item.observable()));
      }
      return _results;
    }).call(this);
    errors = (_ref2 = []).concat.apply(_ref2, errors);
    return errors.length === 0;
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