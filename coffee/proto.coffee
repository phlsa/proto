window.Proto = 
	# Return an object of jQuery elements for easy access
	# Results can be dynamic (always finding elements withing
	# the current document state) or static.
  # Results also can be scoped
	alias: (elems, opts={}) ->
		_.defaults opts, scope:document, static:no
		_.each elems, (item, key) ->
			if opts.static
				val = jQuery(opts.scope).find item
				elems[key] = -> val
			else
				elems[key] = -> jQuery(opts.scope).find item
		elems


	# Shortcut for creating a static alias object
	staticAlias: (elems, opts={}) ->
		_.defaults opts, static:yes
		Proto.alias elems, opts


	# Bind a number of functions to events
	events: (events, opts) ->
		_.defaults opts, scope:document
		_.each events, (fn, key) ->
			event = key.split(' ')[0]
			elem = _.rest key.split(' ')
			jQuery(elem).on event, fn


	# Add a class to an element and automatically remove it
	# after a certain timeout
	pluckClass: (elem, classes, timeout) ->
		elem.toggleClass classes
		Proto.after timeout, -> elem.toggleClass classes


	# Change CSS values of an element and automatically change
	# them back after a certain timeout
	pluckCSS: (elem, props, timeout) ->
		originalValues = {}
		_.each props, (item, key) ->
			originalValues[key] = elem.css(key)
			elem.css(key, props[key])
		Proto.after timeout, ->
			_.each props, (item, key) ->
				elem.css(key, originalValues[key])


	# Perform a function after a certain timeout
	after: (timeout, fn) ->
		window.setTimeout fn, Proto.utils.millis(timeout)


	# Perform a function repeatedly with a certain interval
	every: (timeout, fn) ->
		window.setInterval fn, Proto.utils.millis(timeout)


	# Create a timeline (see class Proto.Timeline)
	timeline: (def) ->
		new Proto.Timeline def


	# Utility functions used within Proto
	utils:
		# Take time in an arbitrary format and convert it to milliseconds
		# Format can be: seconds ("2s"), millisecionds ("2000ms"), millis (2000)
		millis: (input) ->
			input = ''+input
			if input.endsWith 'ms'
				output = input.substr 0, input.length - 2
			else if input.endsWith 's'
				output = (input.substr 0, input.length - 2) * 1000
			else
				output = parseInt input
			output



# Timeline class for sequencing events
class Proto.Timeline
	# Create a new timeline from a definition object. That object must
	# have the time as the key and the action (function) as the value
	constructor: (@def) ->
		@currentKey # get first key out of the definition
		@keyframes = _.map @def, (item, key) ->
			ret =
				time: Proto.utils.millis key
				action: item
		@keyframes = _.sortBy @keyframes, 'time'


	# Start running through the timeline
	start: ->
		_.each @keyframes, (item) ->
			item.timeout = Proto.after item.time, item.action


	# Stop the timeline entirely
	stop: ->
		_.each @keyframes, (item) ->
			window.clearTimeout item.timeout
