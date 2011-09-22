# Knock knock who's there?

A small validation framework for knockout that's who!


##News/Changelog

### 22 sep 2011

You can now define validation rules by passing a configuration object and viewmodel to the validation constructor. The example for this new syntax can be found in example\_short.html. 

### 21 sep 2011

You can now use the custom binding validateCss to add the invalid or valid class based on your observable. Check the example for usage.


##Example

You can find a demo [here](http://knockknock.ep.io/example.html) and [here](http://knockknock.ep.io/example_short.html) which is also included in the repo (example.html).


##Usage

###Create the validation object.
  
    var validation = new validation();

###Add one or more validators to an observable.

    validation.addValidators(observable, validator);

###Validation

The observable now has an .isValid observable and .errors observableArray. Validation is run when observable changes or when you call the global validate method on the validation object.

    validation.validate()


##TODO

  - Throw a few errors around when stuff is missing. Like forgetting to pass the viewmodel to the constructor.

##Run specs

Rather than testing it in the browser KnockKnock  is build with CommonJs modules and tested with Node.js and Jessie. 

First of all you need to have Node.js installed and npm. 

To install Jessie type:

    npm install -g jessie


You can now run tests by typing in the root dir.

    jessie spec 

Jessie is based on Jasmine BDD but adds some extra features and sugar.

##Build 

For now I am just compiling my CoffeeScript files into JavaScript files. In the future I will create one file for easy usage. To compile the src dir to the build dir run:

    ./build.sh

