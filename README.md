# landing

The simplest static landing page module for Express.

## Use case

A Node Express server that needs a landing page to accept new registrations while the service is being prepared for launch. Instead of setting up a separate server, create a set of static landing pages and provide a single callback that will handle the registration requests.

## Usage

1. Put the static landing pages into `public/landing` subdirectory.
2. Make sure that the POST for registration points to `/landing/register`.
3. Configure `landing` with your Express app object and `POST` callback:

        var express = require('express');
        var landing = require('landing');

        app = express();
        app.configure(function() {

            //  Configure your Node service.

            landing.configure(app, function(req, res) {
                //  Code to handle POST to /landing/register:
                //  write to db, send a confirmation email, etc.
            });

            //  Continue configuring your Node service.

        });

## About

The module is written in [Literate CoffeeScript](http://coffeescript.org/) and compiled as `index.js` for usage.

## License

The MIT License (MIT)

Copyright (c) 2014 Software Marbles SpA

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
