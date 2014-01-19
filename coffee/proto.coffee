window.Proto = 
	alias: (elems, opts={}) ->
		_.defaults opts, scope:document, static:no
		_.each elems, (item, key) ->
			if opts.static
				val = jQuery(opts.scope).find item
				elems[key] = -> val
			else
				elems[key] = -> jQuery(opts.scope).find item
		elems


	staticAlias: (elems, opts={}) ->
		_.defaults opts, static:yes
		Proto.alias elems, opts


	events: (events, opts) ->
		_.defaults opts, scope:document
		_.each events, (fn, key) ->
			event = key.split(' ')[0]
			elem = _.rest key.split(' ')
			jQuery(elem).on event, fn


	pluckClass: (elem, classes, timeout) ->
		elem.toggleClass classes
		Proto.after timeout, -> elem.toggleClass classes


	pluckProperties: (elem, props, timeout) ->
		originalValues = {}
		_.each props, (item, key) ->
			originalValues[key] = elem.css(key)
			elem.css(key, props[key])
		Proto.after timeout, ->
			_.each props, (item, key) ->
				elem.css(key, originalValues[key])


	after: (timeout, fn) ->
		window.setTimeout fn, Proto.utils.millis(timeout)


	every: (timeout, fn) ->
		window.setInterval fn, Proto.utils.millis(timeout)


	timeline: (def) ->
		new Proto.Timeline def



	utils:
		millis: (input) ->
			input = ''+input
			if input.endsWith 'ms'
				output = input.substr 0, input.length - 2
			else if input.endsWith 's'
				output = (input.substr 0, input.length - 2) * 1000
			else
				output = parseInt input
			output




class Proto.Timeline
	constructor: (@def) ->
		@currentKey # get first key out of the definition
		@keyframes = _.map @def, (item, key) ->
			ret =
				time: Proto.utils.millis key
				action: item
		@keyframes = _.sortBy @keyframes, 'time'


	start: ->
		_.each @keyframes, (item) ->
			item.timeout = Proto.after item.time, item.action


	stop: ->
		_.each @keyframes, (item) ->
			window.clearTimeout item.timeout
