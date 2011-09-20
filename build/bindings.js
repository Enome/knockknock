(function() {
  var __slice = Array.prototype.slice;
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
}).call(this);
