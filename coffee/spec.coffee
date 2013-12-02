# create aliases for jQuery selectors
elems = Proto.alias
			btn: 'button.main'
			listItems: '.somelist li'


# create static (i.e. non-mutable) aliases for jQuery selectors
stat = Proto.staticAlias
			btn: 'button.main'
			listItems: '.somelist li'
		,
			scope: 'div.scoped'

# test
$('body, .scoped').append($('<button class="main">New button</div>'))
elems.btn().css color:'red'
stat.btn().css 'background-color':'#eee'


# temporarily change attributes of an item
Proto.pluckClass listItems, 'animationName', 3000			# Add a class and automatically remove it after a timeout
Proto.pluckProperty listItems, {opacity: 1}, 2000			# Add properties and automatically remove them after a timeout

# call a bunch of functions in succession
animation = Proto.timeline
	'0s': ->
		doSomeStuff()
	'2s': ->
		doSomeOtherStuff()
		animation.stop() if error?
	'4s': ->
		doEvenDifferentStuff()
	options: 
		autostart: false
		repeat: 'infinite'

animation.start()			# kick off the animation
animation.pause()			# pause the animation
animation.resume()			# resume at the next keyframe

# general delay
Proto.after '2s', -> doStuff()	# having the time value at the end like setTimeout and _.delay is an abomination. let's fix that

Proto.commitAnimations();		# do some magic that makes sure that all subsequent changes are animated and not optimized away
###