// From https://github.com/ConnorAtherton/walkway

// Create a new instance
var svg = new Walkway(options);
// Draw when ready, providing an optional callback
svg.draw(callback);

// Options passed in as an object, see options below.
var svg = new Walkway({ selector: '#jlam'});

// Overwriting defaults
var svg = new Walkway({
  selector: '#jlam',
  duration: '2000',
  // can pass in a function or a string like 'easeOutQuint'
  easing: function (t) {
    return t * t;
  }
});

svg.draw();

// If you don't want to change the default options you can
// also supply the constructor with a selector string.
var svg = new Walkway('#jlam');

svg.draw(function() {
  console.log('Animation finished');
});