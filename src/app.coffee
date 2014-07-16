do ->
    #############################################
    # usasge:
    #   '{0}/{1}'.format hoge, fuga -> "hoge/fuga"
    #############################################
    String::format = () ->
        args = arguments
        callback = (r, s) -> return args[parseInt(s, 10)]
        return this.replace /\{(\w+)\}/g, callback
    return

do ->
    #############################################
    # usasge:
    #   new Date().format("YY/MM/DD") -> 14/07/15
    #############################################
    Date::format = (format) ->
        format = format.replace /YYYY/g, @.getFullYear()
        format = format.replace /YY/g, ( "" + @.getFullYear() ).slice(2, 4)
        format = format.replace /MM/g, ('0' + (@.getMonth() + 1)).slice(-2)
        format = format.replace /DD/g, ('0' + @.getDate()).slice(-2)
        format = format.replace /hh/g, ('0' + @.getHours()).slice(-2)
        format = format.replace /mm/g, ('0' + @.getMinutes()).slice(-2)
        format = format.replace /ss/g, ('0' + @.getSeconds()).slice(-2)
        if format.match /S/g
            milliSeconds = ('00' + @.getMilliseconds()).slice(-3)
            length = format.match(/S/g).length
            format.replace /S/, milliSeconds.substring(i, i + 1) for i in [0...length]
        return format


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
    App.version =
        app : "0.0.1"
        $   : $(w).jquery

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
        @getUrlParams = () ->
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

        #############################################
        # trim at string width 
        #
        # usasge:
        #   App.Util.strimwidth("hoge", 3) -> h...
        #############################################
        @strimwidth = (text, splitCnt = 30, widthStr = "...") ->
            cnt = text.length
            if cnt <= splitCnt
                return text
            newText = text.substr(0, splitCnt)
            return newText + widthStr

    App.Util = Util

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
