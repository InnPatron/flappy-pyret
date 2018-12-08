import list as L
import global as G

import js-file("bindings/pythree") as THREE
import js-file("bindings/pymatter") as MATTER
import js-file("bindings/dom") as DOM
import js-file("ecs/component-store") as CS
import js-file("ecs/uuid") as U
import js-file("animate") as A
import js-file("input") as I
import js-file("helpers") as H

# Constants
ball-radius = 15
sphere-segments = 15

play-area-height = 600

ground-length = 10000
ground-height = 200

general-depth = 20

x-velocity = 5
flap-y-velocity = 6

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


    MATTER.set-velocity(ball-collider, x-velocity, 0)
    MATTER.set-air-friction(ball-collider, 0)

    { 
      vis: ball-vis,
      col: ball-collider 
    }
  end
end

fun ground():
  top-collider = MATTER.rectangle(
    0, 
    0 - (play-area-height / 2) - (ground-height / 2), 
    ground-length, 
    ground-height, 
    true
  )
  bottom-collider = MATTER.rectangle(
    0, 
    (play-area-height / 2) + (ground-height / 2), 
    ground-length, 
    ground-height, 
    true
  )

  ground-geom = THREE.box-geom(ground-length, ground-height, general-depth)
  ground-mat = THREE.simple-mesh-basic-mat(1671168)

  bottom-vis = THREE.mesh(ground-geom, ground-mat)
  top-vis = THREE.mesh(ground-geom, ground-mat)

  block:
    THREE.set-pos-y(bottom-vis, 0 - (play-area-height / 2) - (ground-height / 2))
    THREE.set-pos-y(top-vis, (play-area-height / 2) + (ground-height / 2))
    THREE.scene-add(scene, bottom-vis)
    THREE.scene-add(scene, top-vis)

    MATTER.add-to-world(engine, [L.list: bottom-collider, top-collider])

  end

end

shadow player = player()
shadow ground = ground()

text = DOM.get-element("distance")

context = {
  to-update: [L.list: player],
  player: player
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

    player-pos = THREE.get-pos(context.player.vis)
    string-distance = G.num-to-str(player-pos.x)
    new-text = H.concat-strings([L.list: "Distance: ", string-distance])
    DOM.modify-element(text, "innerHTML", new-text)

    if I.query-input().space:
      block:
        MATTER.set-velocity(context.player.col, x-velocity, 0 - flap-y-velocity)
      end
    else:
      nothing
    end

  end

end

MATTER.run-engine(runner, engine)

A.animate(renderer, scene, camera, animator, context)
