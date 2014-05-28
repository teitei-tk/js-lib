do ->
    #############################################
    # usasge:
    #   '{0}/{1}'.format hoge, fuga -> "hoge/fuga"
    #############################################
    String.prototype.format = () ->
        args = arguments
        callback = (r, s) -> return args[parseInt(s, 10)]
        return this.replace /\{(\w+)\}/g, callback
    return

do (w = window, $ = window.jQuery) ->
    #############################################
    # global object
    #############################################
    App = $.extend {}, w.App
    
    #############################################
    # setting
    #############################################
    App.Config =
        url     :   location.protocol + "//" + location.host
        isDebug :   location.hostname isnt "example.co.jp"


    #############################################
    # lib version
    #############################################
    App.libVersion =
        $ : $(w).jquery

    #############################################
    # utility
    #############################################
    App.Util = {}

    w.App = App
    return

do(w = window, $ = window.jQuery) ->

    #############################################
    # utility class
    #############################################
    class Util
        @LAZY_LOAD : true
        @WAIT_TIME : 2500


        #############################################
        # encode object
        #############################################
        @encodeParams = (params, url) ->
            query = []
            url = url or ''

            for i of param
                query.push i + "=" + encodeURIComponent param[i]
            return url + "?" + query.join '&'


        #############################################
        # bind func
        #############################################
        @bind = (object, func) ->
            return () ->
                return func.apply object, arguments

        #############################################
        # get arguest url parameter
        #############################################
        @parseUrlParams = (url) ->
            index = 0
            params = {}
            hash
            hashes = url.slice( url.indexof("?") + 1 ).split '&'

            for i in hashes
                hash = hashes[index].split '='
                params[hash[0]] = hash[1]
                index += 1
            return params

        #############################################
        # get parameter
        #############################################
        @getUrlParams = (name) ->
            return App.Util.parseUrlParams w.location.href

        #############################################
        # get parameter
        #############################################
        @getUrlParam = (name) ->
            params = App.Util.getUrlParams()
            if not param
                return
            return params[name]

        #############################################
        # redirect manager
        #############################################
        @redirect = (url, params, waitTime) ->
            params = params or {}
            wait = waitTime or App.Util.WAIT_TIME

            if App.Util.LAZY_LOAD
                App.Util.LAZY_LOAD = false

                setTimeout () ->
                    App.Util.LAZY_LOAD = true
                    return
                , wait

                w.location = App.Util.encodeParams params, url
                return

        #############################################
        # escape html
        #############################################
        @escapeHtml = (text) ->
            return (text + "")
                .replace /&/g, '&amp;'
                .replace /</g, '&lt;'
                .replace />/g, '&gt;'
                .replace /"/g, '&quot;'
                .replace /'/g, '&#39;'
                .replace /`/g, '&#96;'

        #############################################
        # unescape html
        #############################################
        @unEscapeHtml = (text) ->
            return ( text + "" )
                .replace /&amp;/g, '&'
                .replace /&lt;/g, '<'
                .replace /&gt;/g, '>'
                .replace /&quot;/g, '"'
                .replace /&#39;/g, '\''
                .replace /&#96;/g, '`'


    App = $.extend {}, w.App
    App.Util = $.extend App.Util, Util
    return

do (w = window) ->
    #############################################
    # console.log of alias
    #############################################
    w.log = () ->
        if App.Config.isDebug
            if w.console and w.console.log
                console.log.bind console
            else
                text = Array.prototype.join.apply arguments, [', ']
                alert text
                return
    return


            
