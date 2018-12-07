function animate(renderer, scene, camera, animator, context) {
  function innerAnimation(time) {
    requestAnimationFrame( innerAnimation );
    animator(context);
    renderer.render(scene, camera);
  }

  innerAnimation();
}

module.exports = {
  'animate': animate,
};
