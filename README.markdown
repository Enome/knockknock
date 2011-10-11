# Knock-Knock who's there?

A small validation framework for knockout that's who!


##Examples

[example.html](http://knockknock.ep.io/example.html)
[example\_advanced.html](http://knockknock.ep.io/example_advanced.html)


##Usage

###Basic usage

For basic validation you can just use the kk.observable.

    viewmodel = {
      name  : kk.observable( 'Jimi', new kk.validators.Required() ),
      email : kk.observable( '', [ new kk.validators.Email(), new kk.validators.Required() ] )
    }


Since a kk.observable is just a DO (ko.dependentObservable) you can also pass in a ko.observable as the first argument and the DO will use that as the underlying observable.

    viewmodel = { 
      name : kk.observable( ko.observable('Jimi'), new kk.validators.Required() ) 
    }


A kk.observable has an observableArray called errors and an observable isValid. You can use these in your html to render/show errors.

    viewmodel.name.isValid() //true or false
    viewmodel.name.errors()  //Array with strings/error messages


#####Note:

If an observable is never changed validation will never run. This is something you need to keep in mind if you are using Required and the user doesn't touch the input box. You can force validation by calling observable.validate()

    viewmodel.name.validate()


###Advanced usage

For more advanced usage kk has a Validation class. This class takes a viewmodel and a configuration file.

    viewmodel = {
      name : ko.observable(),
      email : ko.observable()
    }


    configuration = {
      name : new kk.validators.Required(),
      email : [ new kk.validators.Email(), new kk.validators.Required() ] 
    }

    validation = new kk.Validation viewmodel, configuration

This will replace your observables with kk.observables with the correct validation rules. Since the above example doesn't use default values for the observables you can just leave them out if you want.

    viewmodel = { }

    configuration = {
      name : new kk.validators.Required(),
      email : [ new kk.validators.Email(), new kk.validators.Required() ] 
    }

    validation = new kk.Validation viewmodel, configuration

Knock-Knock will add the observables name and email.

The Validation class also has a validate method that will run validate on all the observables it knows. 

    validation = new kk.Validation viewmodel, configuration
    validation.validate()


Like kk.observable Validation also has isValid.

    validation = new kk.Validation viewmodel, configuration
    validation.isValid

#####Note:

Just like the kk.observable you need to keep in mind that if the user didn't touch required fields isValid might not be set. You can call Validation.validate to be sure all the observables were validated.


###Custom validators

Knock-Knock ships with a few common validators. The validators are really small classes so it's easy to create your own. A validator just needs a validate method that takes a value and returns true or false. Check the src/validators.coffee file to see the default validators.


###Custom error messages

All default validators take a message as a constructor argument. 

    new kk.validators.Max(5, 'Way to long dude'),


###Always write

kk.observable and Validation have a third argument which is called always write. By default this parameter is set to true and it means that observables are always updated even if the value is invalid. If you for example use a flag to track dirty observables ( aka changed observables ) and you use that to write to the database you can use put the alwaysWrite to false. That way the observable wont be updated if the value is invalid. The downside of this is that your UI and your viewmodel aren't synchronized anymore. 

    viewmodel = {
      name  : kk.observable( 'Jimi', new kk.validators.Required(), false )
    }

    validation = new kk.Validation viewmodel, configuration, false


###Custom binding

Knock-Knock has a validateCss binding which takes a kk.observable and adds a valid or invalid class to a html element. 

    viewmodel = {
      name  : kk.observable( 'Jimi', new kk.validators.Required() )
    }

    <input type='text' data-bind='value: name, validateCss: name' />


#####Note:

If you have alwaysWrite to false you can't use the validateCss binding on the input field because it will try and refresh the observable which in this case still holds the old valid value. Instead you need to wrap your field with an other element. This is the reason why always write isn't false by default since it can be confusing. (it was to me)


    <label data-bind='validateCss: name'>
      <input type='text' data-bind='value: name' />
    </label>


##Run specs

Rather than testing it in the browser KnockKnock  is build with CommonJs modules and tested with Node.js and Jessie. 

First of all you need to have Node.js installed and npm. 

To install Jessie type:

    npm install -g jessie


You can now run tests by typing in the root dir.

    jessie spec 

Jessie is based on Jasmine BDD but adds some extra features and sugar.

##Build 

This will merge all the files and add window.kk = {} at the top.

    ./build.js

