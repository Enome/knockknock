(function() {
  var Validation;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __slice = Array.prototype.slice;
  Validation = (function() {
    function Validation() {
      this.validate = __bind(this.validate, this);      this.cache = [];
    }
    Validation.prototype.addValidator = function() {
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
    Validation.prototype.validate = function() {
      var item, _i, _len, _ref, _results;
      _ref = this.cache;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(this._validate.apply(this, [item.observable].concat(__slice.call(item.validators))));
      }
      return _results;
    };
    return Validation;
  })();
  if (typeof exports !== "undefined" && exports !== null) {
    exports.Validation = Validation;
  }
  window.Validation = Validation;
}).call(this);
