// Generated by CoffeeScript 1.6.3
(function() {
  var animation, elems, stat;

  elems = Proto.alias({
    btn: 'button.main',
    listItems: '.somelist li'
  });

  stat = Proto.staticAlias({
    btn: 'button.main',
    listItems: '.somelist li'
  }, {
    scope: 'div.scoped'
  });

  $('.scoped').append($('<button class="main">Dynamic in scope</div>'));

  $('body').append($('<button class="main">Dynamic out of scope</div>'));

  elems.btn().css({
    color: 'red'
  });

  stat.btn().css({
    'background-color': '#bbb'
  });

  Proto.pluckClass(elems.listItems(), 'someClass', 3000);

  Proto.pluckProperties(elems.listItems(), {
    opacity: 1
  }, 2000);

  animation = Proto.timeline({
    '0s': function() {
      return doSomeStuff();
    },
    '2s': function() {
      doSomeOtherStuff();
      if (typeof error !== "undefined" && error !== null) {
        return animation.stop();
      }
    },
    '4s': function() {
      return doEvenDifferentStuff();
    },
    options: {
      autostart: false,
      repeat: 'infinite'
    }
  });

  /*
  animation.start()			# kick off the animation
  animation.pause()			# pause the animation
  animation.resume()			# resume at the next keyframe
  
  # general delay
  Proto.after '2s', -> doStuff()	# having the time value at the end like setTimeout and _.delay is an abomination. let's fix that
  
  Proto.commitProperties elems.btn(), 'opacity', 'transform';		# do some magic that makes sure that all subsequent changes are animated and not optimized away
  */


}).call(this);
