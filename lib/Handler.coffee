Html = require './html/Html'
Replace = require './Replace'
Stylesheets = require './styles/Stylesheets'


class Handler
    # Handles cli operations

    @html: (target, input, output) ->
        return new Html target, input, output

    @stylesheets: (target, output) ->
        return new Stylesheets target, output

    @compile: (what, target, output, options) ->
        if what == 'pug'
            html = Handler.html target, options.input, output
            html.makePages()
        else if what == 'scss'
            stylesheets = Handler.stylesheets target, output
            stylesheets.compile()
        else if what == 'replace'
            Replace.replace(target, options.input, output)

module.exports = Handler
