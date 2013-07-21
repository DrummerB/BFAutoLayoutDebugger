# BFAutoLayoutDebugger

![Screenshot](http://i.imgur.com/0r7xCp8.png)

Summary
-------

`BFAutoLayoutDebugger` is very simply framework that can display the view hierarchy of your app's main window. Selecting any of the views from the list will visualize the constraints affecting the layout of those views using the `NSWindow` helper method `visualizeConstraints:`.

Instructions
------------

Include the framework in your project. You can add a menu to toggle the debug panel by calling 

    [[BFAutoLayoutDebugger sharedDebugger] addMenu];
    
in your `applicationDidFinishLaunching:` method. Of course you only want to enable this for debug builds and not for release. You can also call

    [[BFAutoLayoutDebugger sharedDebugger] showPanel];
    
to to display the panel programmatically. You shouldn't do this before `awakeFromNib:` of your app delegate was called. See the Demo app for an example.

License
-------

[New BSD License](http://en.wikipedia.org/wiki/BSD_licenses). For the full license text, see [here](https://raw.github.com/DrummerB/BFAutoLayoutDebugger/master/License).

Credits
-------
`BFAutoLayoutDebugger` was created by [Balázs Faludi](https://github.com/DrummerB).</br>
You can e-mail me at <balazsfaludi@gmail.com>.