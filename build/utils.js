(function() {
  ko.utils.removeClass = function(element, className) {
    var regex;
    regex = new RegExp("(?:^|\s)" + className + "(?!\S)");
    return element.className = element.className.replace(regex, '');
  };
}).call(this);
