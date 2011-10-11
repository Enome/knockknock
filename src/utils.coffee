kk.utils =
  removeClass : (element, className)->
    regex = new RegExp "(?:^|\\s)#{className}(?!\\S)"
    element.className = element.className.replace regex, ''

  isArray : (obj)->
    Object.prototype.toString.call(obj) is '[object Array]'
