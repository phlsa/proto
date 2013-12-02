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


	pluckClass: (elem, classes, timeout) ->
		elem().toggleClass classes
		Proto.after timeout, -> elem().toggleClass classes