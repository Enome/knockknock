# Knock knock who's there?

A small validation framework for knockout that's who! Didn't know what to name it and Knockout.validation might be already taken.


##Example

You can find a demo [here](http://knockknock.ep.io/example.html) which is also included in the repo (example.html).


##Usage

###Create the validation object.
  
    var validation = new validation();

###Add one or more validators to an observable.

    validation.addValidators(observable, validator);

###Validation

The observable now has an .isValid observable and .errors observableArray. Validation is run when observable changes or when you call the global validate method on the validation object.

    validation.validate()


##TODO

 - Research the new extend systax in 1.3: http://groups.google.com/group/knockoutjs/msg/3289474946c2675b 

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

