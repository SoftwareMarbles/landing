
    expect  = require('chai').expect
    express = require('express')
    http    = require('http')
    landing = require('../index')
    request = require('supertest')

    describe 'landing server', ->

Setup our test server.

        postCallbackTest = null
        postCallbackRedirect = (req, res) ->
            return postCallbackTest req, res

        app = express()
        port = process.env.PORT or 8080
        app.configure ->
            app.set 'port', port
            landing.configure app, postCallbackRedirect
            app.use app.router

        http.createServer(app).listen app.get('port')

        it 'doesn\'t server anything but from /landing route', (done) ->
            request app
                .get '/'
                .expect 404, done

        it 'serves index.html from /landing', (done) ->
            request app
                .get '/landing'
                .set 'Accept', 'application/html'
                .expect 'Content-Type', /html/
                .expect 200, done

        it 'serves other content (html) from /landing', (done) ->
            request app
                .get '/landing/index.html'
                .set 'Accept', 'application/html'
                .expect 'Content-Type', /html/
                .expect 200, done

        it 'serves other content (jpg) from /landing', (done) ->
            request app
                .get '/landing/images/landing.jpg'
                .set 'Accept', 'application/html'
                .expect 'Content-Type', /jpeg/
                .expect 200, done

        it 'accepts POST to /landing/register', (done) ->
            callbackInvoked = false
            postCallbackTest = (req, res) ->
                callbackInvoked = true
                expect(req.query).to.be.ok
                expect(req.query).to.have.property 'email'
                expect(req.query.email).to.equal 'test@example.com'
                res.redirect '/landing'

            request app
                .post '/landing/register?email=test@example.com'
                .expect 'Content-Type', /text\/plain/
                .expect 302, (err) ->
                    return done err if err
                    expect(callbackInvoked).to.be.true
                    done()
