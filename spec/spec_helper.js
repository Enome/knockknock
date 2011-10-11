require('jessie').sugar();
require('coffee-script');

global.window = {};
global.navigator = {};

require('../lib/knockout-1.3.0beta.debug');
global.ko = window.ko;

global.kk = {}
require('../src/validators');
require('../src/validation');
require('../src/observable');

require('../src/utils');
require('../src/bindings');
