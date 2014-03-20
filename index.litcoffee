
Landing module configures Express app to serve all the static content in `public/landing` subdirectory and to accept `POST` to `/landing/register`. The POST request is send back to the user of the module through a callback. Static pages are served through `node-static` module.

    exports.configure = (expressApp, registerCallback) ->
        nodeStatic = require('node-static')
        staticServer = new nodeStatic.Server('./public')

        # Redirect register POST to the given registerCallback
        expressApp.post '/landing/register', registerCallback

        expressApp.get '/landing', (req, res) ->
            staticServer.serveFile 'landing/index.html', 200, {}, req, res

        expressApp.get /\/landing\/.*/, (req, res) ->
            staticServer.serve req, res
