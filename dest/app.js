(function() {
  (function() {
    String.prototype.format = function() {
      var args, callback;
      args = arguments;
      callback = function(r, s) {
        return args[parseInt(s, 10)];
      };
      return this.replace(/\{(\w+)\}/g, callback);
    };
  })();

  (function(w, $) {
    var App;
    App = $.extend({}, w.App);
    App.Config = {
      url: location.protocol + "//" + location.host,
      isDebug: location.hostname !== "example.co.jp"
    };
    App.libVersion = {
      $: $(w).jquery
    };
    App.Util = {};
    w.App = App;
  })(window, window.jQuery);

  (function(w, $) {
    var App, Util;
    Util = (function() {
      function Util() {}

      Util.LAZY_LOAD = true;

      Util.WAIT_TIME = 2500;

      Util.encodeParams = function(params, url) {
        var i, query;
        query = [];
        url = url || '';
        for (i in param) {
          query.push(i + "=" + encodeURIComponent(param[i]));
        }
        return url + "?" + query.join('&');
      };

      Util.bind = function(object, func) {
        return function() {
          return func.apply(object, arguments);
        };
      };

      Util.parseUrlParams = function(url) {
        var hash, hashes, i, index, params, _i, _len;
        index = 0;
        params = {};
        hash;
        hashes = url.slice(url.indexof("?") + 1).split('&');
        for (_i = 0, _len = hashes.length; _i < _len; _i++) {
          i = hashes[_i];
          hash = hashes[index].split('=');
          params[hash[0]] = hash[1];
          index += 1;
        }
        return params;
      };

      Util.getUrlParams = function(name) {
        return App.Util.parseUrlParams(w.location.href);
      };

      Util.getUrlParam = function(name) {
        var params;
        params = App.Util.getUrlParams();
        if (!param) {
          return;
        }
        return params[name];
      };

      Util.redirect = function(url, params, waitTime) {
        var wait;
        params = params || {};
        wait = waitTime || App.Util.WAIT_TIME;
        if (App.Util.LAZY_LOAD) {
          App.Util.LAZY_LOAD = false;
          setTimeout(function() {
            App.Util.LAZY_LOAD = true;
          }, wait);
          w.location = App.Util.encodeParams(params, url);
        }
      };

      Util.escapeHtml = function(text) {
        return (text + "").replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/`/g, '&#96;');
      };

      Util.unEscapeHtml = function(text) {
        return (text + "").replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&#39;/g, '\'').replace(/&#96;/g, '`');
      };

      return Util;

    })();
    App = $.extend({}, w.App);
    App.Util = $.extend(App.Util, Util);
  })(window, window.jQuery);

  (function(w) {
    w.log = function() {
      var text;
      if (App.Config.isDebug) {
        if (w.console && w.console.log) {
          return console.log.bind(console);
        } else {
          text = Array.prototype.join.apply(arguments, [', ']);
          alert(text);
        }
      }
    };
  })(window);

}).call(this);