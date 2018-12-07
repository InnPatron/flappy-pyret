var THREE = require('three');

module.exports = {
  'scene': function() {
    return new THREE.Scene();
  },

  'perspective-camera': function(fov, aspectRatio, near, far) {
    return new THREE.PerspectiveCamera( fov, aspectRatio, near, far );
  },

  'perspective-camera-default': function() {
    return new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );
  },

  'web-gl-renderer': function(width, height) {
    var renderer = new THREE.WebGLRenderer();
    renderer.setSize( width, height );
    document.body.appendChild( renderer.domElement );

    return renderer;
  },

  'web-gl-renderer-default': function() {
    var renderer = new THREE.WebGLRenderer();
    renderer.setSize( window.innerWidth, window.innerHeight );
    document.body.appendChild( renderer.domElement );

    if (renderer.render === undefined) {
      throw "NO RENDER";
    }

    return renderer;
  },

  'box-geom': function(width, height, depth) {
    return new THREE.BoxGeometry(width, height, depth);
  },

  'sphere-geom': function(radius, widthSegments, heightSegments) {
    return new THREE.SphereGeometry(radius, widthSegments, heightSegments);
  },

  'shape-geom': function(shape) {
    return new THREE.ShapeGeometry(shape);
  },

  'shape': function() {
    return new THREE.Shape();
  },

  'shape-move-to': function(shape, x, y) {
    shape.moveTo(x, y);
  },

  'shape-line-to': function(shape, x, y) {
    shape.lineTo(x, y);
  },

  'simple-mesh-basic-mat': function(color) {
    return new THREE.MeshBasicMaterial( { color: color } );
  },

  'mesh': function(geom, material) {
    return new THREE.Mesh(geom, material);
  },

  'get-pos': function(obj3d) {
    return obj3d.position.clone();
  },

  'set-pos': function(obj3d, x, y, z) {
    obj3d.position.x = x;
    obj3d.position.y = y;
    obj3d.position.z = z;
  },

  'set-pos-x': function(obj3d, x) {
    obj3d.position.x = x;
  },

  'set-pos-y': function(obj3d, y) {
    obj3d.position.y = y;
  },

  'set-pos-z': function(obj3d, z) {
    obj3d.position.z = z;
  },

  'get-rot': function(obj3d) {
    return obj3d.rotation.clone();
  },

  'set-rot': function(obj3d, x, y, z) {
    obj3d.rotation.x = x;
    obj3d.rotation.y = y;
    obj3d.rotation.z = z;
  },

  'set-rot-x': function(obj3d, x) {
    obj3d.rotation.x = x;
  },

  'set-rot-y': function(obj3d, y) {
    obj3d.rotation.y = y;
  },

  'set-rot-z': function(obj3d, z) {
    obj3d.rotation.z = z;
  },

  'deg-to-rad': function(deg) {
    return THREE.Math.degToRad(deg);
  },

  'scene-add': function(scene, obj3d) {
    scene.add(obj3d);
  },

  'render': function(renderer, scene, camera) {
    renderer.render( scene, camera );
  },

};
