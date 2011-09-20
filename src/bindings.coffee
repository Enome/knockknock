###
ko.bindingHandlers.validateCss = {
  init : function(element, valueAccessor){
    var observable = valueAccessor()

    ko.utils.removeClass(element, 'valid');
    ko.utils.removeClass(element, 'invalid');

    if(observable.isValid()){
        element.className += 'valid';
    } else {
        element.className += 'invalid';
    };
  },

  update : function(element, valueAccessor){
      ko.bindingHandlers.validateCss.init(element, valueAccessor);
  }

};
###

