(function() {
  var Validation;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __slice = Array.prototype.slice;
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
      var errors, interceptor, isValid, observable, validators;
      observable = arguments[0], validators = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      errors = ko.observableArray();
      isValid = ko.dependentObservable(function() {
        return errors().length === 0;
      });
      interceptor = ko.dependentObservable({
        read: observable,
        write: __bind(function(value) {
          errors(this.runValidators(validators, value));
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
      return interceptor;
    };
    Validation.prototype.runValidators = function(validators, value) {
      var validator, _i, _len, _results;
      if (!!validator.validate(value)) {
        _results = [];
        for (_i = 0, _len = validators.length; _i < _len; _i++) {
          validator = validators[_i];
          _results.push(validator.message);
        }
        return _results;
      }
    };
    Validation.prototype.validate = function() {
      var errors, _ref;
      errors = [];
      errors = (_ref = []).concat.apply(_ref, errors);
      return errors.length === 0;
    };
    return Validation;
  })();
  if (typeof exports !== "undefined" && exports !== null) {
    exports.Validation = Validation;
  }
  window.Validation = Validation;
}).call(this);
