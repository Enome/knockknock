#! /usr/bin/env node

var fs = require('fs');
var Coffeescript = require('coffee-script');

var files = fs.readdirSync(__dirname + '/src');
var concatinatedFiles = 'window.kk={}\n';

for(var i = 0; i < files.length; i += 1){
    var path = __dirname + '/src/' + files[i]
    concatinatedFiles += fs.readFileSync(path, 'utf8');
};

var js = Coffeescript.compile( concatinatedFiles, {bare:true} )

fs.writeFile(__dirname + '/build/kk.js', js);
