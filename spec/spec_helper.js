require('jessie').sugar();
require('coffee-script');

global.window = {};
global.navigator = {};

require('../lib/knockout-1.3.0beta.debug');
global.ko = window.ko;

require('../src/utils');
