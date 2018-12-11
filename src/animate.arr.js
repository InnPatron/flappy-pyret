var animationContext = undefined;
var pause = false;

function animate(renderer, animator) {
  function innerAnimation(time) {
      requestAnimationFrame( innerAnimation );
      animator(animationContext);
  }

  innerAnimation();
}

module.exports = {
  'set-context': function(context) {
    animationContext = context;
  },
  'animate': animate,
};
