Td = require 'testdouble'

Chai = require 'chai'

Html = require '../lib/html/Html'
Handler = require '../lib/Handler'
Replace = require '../lib/Replace'
Stylesheets = require '../lib/styles/Stylesheets'


describe 'the Handler module', ->

    it 'should have an html method', ->
        result = Handler.html 'target', 'input', 'output'
        Chai.expect(result).to.be.an.instanceof(Html)
        Chai.expect(result.template).to.eql('target')
        Chai.expect(result.content).to.eql('input')
        Chai.expect(result.output).to.eql('output')

    it 'should have a stylesheets method', ->
        result = Handler.stylesheets 'file', 'output'
        Chai.expect(result).to.be.an.instanceof(Stylesheets)
        Chai.expect(result.file).to.eql('file')
        Chai.expect(result.output).to.eql('output')

    describe 'should have a compile method', ->
        it 'should be able to compile pug templates', ->
            Td.replace Handler, 'html'
            makePages = Td.function()
            Td
                .when(Handler.html('target', 'input', 'output'))
                .thenReturn({makePages: makePages})
            Handler.compile 'pug', 'target', 'output', {input: 'input'}
            Td.verify(makePages())

        it 'should be able to compile Sass files', ->
            Td.replace Handler, 'stylesheets'
            compile = Td.function()
            Td
                .when(Handler.stylesheets('target', 'output'))
                .thenReturn({compile: compile})
            Handler.compile 'scss', 'target', 'output', {input: 'input'}
            Td.verify(compile())

        it 'should be able to run replace operations', ->
            Td.replace Replace, 'replace'
            Handler.compile 'replace', 'target', 'output', {input: 'input'}
            Td.verify(Replace.replace('target', 'input', 'output'))

    afterEach ->
        Td.reset()
