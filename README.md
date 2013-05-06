Weather Desktop - An advanced weather app
=========================================

Check the weather in a simple and easy-to-use manner. With no ads and a beautiful interface, it's easier and faster than checking weather websites!

Weather Desktop provides access to multiple named locations, with previews of all available at the same time. It displays detailed current conditions,  daily forecasts for the next seven days, and hourly forecasts for the next 24 hours. For people on the go, Weather Desktop can automatically determine your location using your IP address. In addition, users can easily add their own backgrounds, weather-related or not, to the application. 

Don't want to open the application? Just enable the option to set your current wallpaper to depict the current weather conditions!

### Features ###

_**Warning:** this software is in a pre-release stage and is under active development! Most of the features listed below do not work yet or are in a non-working state._

 * Runs on any system that supports the KDE libraries
 * Multiple named locations
 * List of 10 recent locations
 * Current weather conditions
 * Weather forecasts for 10 days
 * Severe weather alerts
 * Background of app depicts current conditions
 * User can add additional backgrounds (weather-related or not)

### Requirements ###
 * KDE 4.x
 * QJson (http://qjson.sourceforge.net)

### Build Requirements ###
 * Class Generator (https://github.com/iBeliever/qclassgen)

### Acknowledgments ###

 * Development by Michael Spencer (@iBeliever)
 * Design by Michael Spencer (@iBeliever) and Christopher Spencer
 * Powered by World Weather Online
 * Powered by [Weather Underground](http://www.wunderground.com/?apiref=f7b0e81e954c09e8)

   ![Weather Underground](http://icons-ak.wxug.com/graphics/wu2/logo_130x80.png)

### Licensing ###

Weather Desktop is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.


Installation
------------

### Ubuntu ###

If you are using Ubuntu, you can buy the application from the Ubuntu Software Center for $2.99. It will help to support my work, plus you will get a prepackaged, automatically updated version of the application that also contains my API key precompiled into it. _**Note:** it is not yet available in the Software Center, but hopefully soon will!_

### Building from Source ###

**API Key**

When building from source, you will need an API key from World Weather Online or [Weather Underground](http://www.wunderground.com/?apiref=f7b0e81e954c09e8).

Once you have an API key, create a file called `src/api_key.h` and add your API key to it:

    #define WWO_API_KEY "<your-key-here>" // For World Weather Online
    #define WUNDER_API_KEY "<your-key-here>" // For Wunderground

    
**Class Generator**

Weather Desktop uses Class Generator to build some files, so [download it](https://github.com/iBeliever/qclassgen/archive/master.zip) and extract it to a directory called `classgen`.

**Dependencies under Debian/Ubuntu**

Under Debian, Ubuntu, or any of their derivatives, you can easily install the necessary dependencies as follows:

    $ sudo apt-get install build-essential cmake kdelibs5-dev libqjson-dev

**From the command line under Unix/Linux:**

    $ cd <project_name_path>
    $ mkdir build
    $ cd build
    $ cmake -DCMAKE_INSTALL_PREFIX=/path/to/install ..
    $ make all
    $ make install # or 'sudo make install' if installing in a root directory
    
If you do not specify an installation prefix, Weather Desktop will be installed in `/usr/local`.

**From the command line under Windows:**

    > cd <project_name_path>
    > mkdir build
    > cd build
    > cmake -DCMAKE_INSTALL_PREFIX=C:\path\to\install ..
    > [n]make
    > [n]make install
    
_**Note:** Use `nmake` if you are using the Visual Studio compiler or `make` if you are using MinGW._
