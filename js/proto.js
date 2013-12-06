// Generated by CoffeeScript 1.6.3
(function() {
  window.Proto = {
    alias: function(elems, opts) {
      if (opts == null) {
        opts = {};
      }
      _.defaults(opts, {
        scope: document,
        "static": false
      });
      _.each(elems, function(item, key) {
        var val;
        if (opts["static"]) {
          val = jQuery(opts.scope).find(item);
          return elems[key] = function() {
            return val;
          };
        } else {
          return elems[key] = function() {
            return jQuery(opts.scope).find(item);
          };
        }
      });
      return elems;
    },
    staticAlias: function(elems, opts) {
      if (opts == null) {
        opts = {};
      }
      _.defaults(opts, {
        "static": true
      });
      return Proto.alias(elems, opts);
    },
    pluckClass: function(elem, classes, timeout) {
      elem.toggleClass(classes);
      return Proto.after(timeout, function() {
        return elem.toggleClass(classes);
      });
    },
    pluckProperties: function(elem, props, timeout) {
      var originalValues;
      originalValues = {};
      _.each(props, function(item, key) {
        originalValues[key] = elem.css(key);
        return elem.css(key, props[key]);
      });
      return Proto.after(timeout, function() {
        return _.each(props, function(item, key) {
          return elem.css(key, originalValues[key]);
        });
      });
    },
    after: function(timeout, fn) {
      return window.setTimeout(fn, Proto.utils.millis(timeout));
    },
    every: function(timeout, fn) {
      return window.setInterval(fn, Proto.utils.millis(timeout));
    },
    timeline: function(def) {
      return new Proto.Timeline(def);
    },
    utils: {
      millis: function(input) {
        var output;
        input = '' + input;
        if (input.endsWith('ms')) {
          output = input.substr(0, input.length - 2);
        } else if (input.endsWith('s')) {
          output = (input.substr(0, input.length - 2)) * 1000;
        } else {
          output = parseInt(input);
        }
        return output;
      }
    }
  };

  Proto.Timeline = (function() {
    function Timeline(def) {
      this.def = def;
      this.currentKey;
      this.keyframes = _.map(this.def, function(item, key) {
        var ret;
        return ret = {
          time: Proto.utils.millis(key),
          action: item
        };
      });
      this.keyframes = _.sortBy(this.keyframes, 'time');
    }

    Timeline.prototype.start = function() {
      return _.each(this.keyframes, function(item) {
        return item.timeout = Proto.after(item.time, item.action);
      });
    };

    Timeline.prototype.stop = function() {
      return _.each(this.keyframes, function(item) {
        return window.clearTimeout(item.timeout);
      });
    };

    return Timeline;

  })();

}).call(this);
