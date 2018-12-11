var MATTER = require('matter-js');


module.exports = {
  'create-engine': function() {
    return MATTER.Engine.create();
  },

  'create-runner': function() {
    return MATTER.Runner.create();
  },

  'rectangle': function(x, y, width, height, staticBody) {
    return MATTER.Bodies.rectangle(x, y, width, height, { isStatic: staticBody });
  },

  'circle': function(x, y, radius, staticBody) {
    return MATTER.Bodies.circle(x, y, radius, { isStatic: staticBody });
  },

  'polygon': function(x, y, sides, radius, staticBody) {
    return MATTER.Bodies.polygon(x, y, sides, radius, { isStatic: staticBody });
  },

  'trapezoid': function(x, y, width, height, slope, staticBody) {
    return MATTER.Bodies.trapezoid(x, y, width, height, slope, { isStatic: staticBody });
  },

  'set-restitution': function(body, restitution) {
    body.restitution = restitution;
  },

  'set-air-friction': function(body, airFriction) {
    body.frictionAir = airFriction;
  },

  'add-to-world': function(engine, bodies) {
    MATTER.World.add(engine.world, bodies);
  },

  'run-engine': function(runner, engine) {
    MATTER.Runner.run(runner, engine);
  },

  'start-runner': function(runner) {
    // Equivalent to run-engine()
    MATTER.Runner.start(runner);
  },

  'stop-runner': function(runner) {
    MATTER.Runner.stop(runner);
  },

  'get-pos': function(body) {
    return MATTER.Vector.clone(body.position);
  },

  'get-pos-x': function(body) {
    return body.position.x;
  },

  'get-pos-y': function(body) {
    return body.position.y;
  },

  'set-pos': function(body, x, y) {
    return MATTER.Body.setPosition(body, { x: x, y: y });
  },

  'set-pos-x': function(body, x) {
    return MATTER.Body.setPosition(body, { x: x, y: body.position.y });
  },

  'set-pos-y': function(body, y) {
    return MATTER.Body.setPosition(body, { x: body.position.x, y: y });
  },

  'get-angle': function(body) {
    return body.angle;
  },

  'set-angle': function(body, radians) {
    MATTER.Body.setAngle(body, radians);
  },

  'set-velocity': function(body, x, y) {
    MATTER.Body.setVelocity(body, { x: x, y: y });
  },

  'constraint-create': function(bodyA, bodyB, options) {
    options["bodyA"] = bodyA;
    options["bodyB"] = bodyB;
    return MATTER.Constraint.create(options);
  },

  'composite-create': function(bodies, constraints) {
    return MATTER.Composite.create({ bodies: bodies, constraints: constraints});
  },

  'composite-translate': function(composite, x, y) {
    MATTER.Composite.translate(composite, x, y);
  },

  'next-group': function() {
    return MATTER.Body.nextGroup(true);
  },

  'next-category': function() {
    return MATTER.Body.nextCategory();
  },

  'set-collision-group': function(body, group) {
    body.collisionGroup = group;
  },

  'set-collision-catgeory': function(body, category) {
    body.collisionFilter.category = category;
  },

  'set-collision-mask': function(body, mask) {
    body.collisionFilter.mask = mask;
  },

  'collides': function(bodyA, bodyB) {
    return MATTER.SAT.collides(bodyA, bodyB).collided;
  },
};
