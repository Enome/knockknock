ko.utils.removeClass = (element, className)->
  regex = new RegExp "(?:^|\\s)#{className}(?!\\S)"
  element.className = element.className.replace regex, ''
