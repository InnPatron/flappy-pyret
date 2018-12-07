import list as L

import js-file("bindings/pythree") as THREE
import js-file("bindings/pymatter") as MATTER
import js-file("ecs/component-store") as CS
import js-file("ecs/uuid") as U
import js-file("animate") as A

# Constants
ball-radius = 15
sphere-segments = 15

# World init
scene = THREE.scene()
camera = THREE.perspective-camera-default()
renderer = THREE.web-gl-renderer-default()

THREE.set-pos-z(camera, 600)

engine = MATTER.create-engine()
runner = MATTER.create-runner()

# Init functions 
fun player():
  ball-collider = MATTER.circle(0, 0, ball-radius, false)
  ball-geom = THREE.sphere-geom(ball-radius, sphere-segments, sphere-segments)
  ball-mat = THREE.simple-mesh-basic-mat(33023)

  ball-vis = THREE.mesh(ball-geom, ball-mat)

  block: 
    THREE.scene-add(scene, ball-vis)
    MATTER.add-to-world(engine, [L.list: ball-collider])

    { 
      vis: ball-vis,
      col: ball-collider 
    }
  end
end

shadow player = player()

context = {
  to-update: [L.list: player]
}

animator = lam(shadow context):
  block:

    for L.map(u from context.to-update):

      block:
        new-pos = MATTER.get-pos(u.col)
        THREE.set-pos-x(u.vis, new-pos.x)
        THREE.set-pos-y(u.vis, 0 - new-pos.y)

        u
      end

    end
  end

end

MATTER.run-engine(runner, engine)

A.animate(renderer, scene, camera, animator, context)
