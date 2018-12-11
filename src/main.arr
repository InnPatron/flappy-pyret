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

obstacle-height = play-area-height
obstacle-width = ball-radius * ( 3 / 2 )
obstacle-gap = ball-radius * 6

# Collision stuff
obstacle-group = -1
player-group = 1
main-collision-category = MATTER.next-category()

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

    MATTER.set-collision-group(ball-collider, player-group)
    MATTER.set-collision-catgeory(ball-collider, main-collision-category)
    MATTER.set-collision-mask(ball-collider, main-collision-category)

    MATTER.set-velocity(ball-collider, x-velocity, 0)
    MATTER.set-air-friction(ball-collider, 0)

    { 
      vis: ball-vis,
      col: ball-collider 
    }
  end
end

fun obstacle(x, y):
  top = MATTER.rectangle(
    x,
    y - (obstacle-height / 2) - (obstacle-gap / 2),
    obstacle-width,
    obstacle-height,
    true
  )

  bottom = MATTER.rectangle(
    x,
    y + (obstacle-height / 2) + (obstacle-gap / 2),
    obstacle-width,
    obstacle-height,
    true
  )

  # TODO: FIGURE OUT HOW MATTERJS COMPOUND WORKS

  obstacle-geom = THREE.box-geom(obstacle-width, obstacle-height, general-depth)
  obstacle-mat = THREE.simple-mesh-basic-mat(1671168)
  
  top-vis = THREE.mesh(obstacle-geom, obstacle-mat)
  bottom-vis = THREE.mesh(obstacle-geom, obstacle-mat)

  block:
    MATTER.set-collision-group(top, obstacle-group)
    MATTER.set-collision-group(bottom, obstacle-group)
    MATTER.set-collision-catgeory(top, main-collision-category)
    MATTER.set-collision-catgeory(bottom, main-collision-category)
    MATTER.set-collision-mask(top, main-collision-category)
    MATTER.set-collision-mask(bottom, main-collision-category)

    MATTER.add-to-world(engine, [L.list: top, bottom])

    THREE.set-pos(top-vis, MATTER.get-pos-x(top), 0 - MATTER.get-pos-y(top), 0)
    THREE.set-pos(bottom-vis, MATTER.get-pos-x(bottom), 0 - MATTER.get-pos-y(bottom), 0)
    THREE.scene-add(scene, top-vis)
    THREE.scene-add(scene, bottom-vis)

    shadow top = { col: top, vis: top-vis }
    shadow bottom = { col: bottom, vis: bottom-vis }

    { top: top, bottom: bottom }
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


    MATTER.set-collision-group(top-collider, obstacle-group)
    MATTER.set-collision-group(bottom-collider, obstacle-group)
    MATTER.set-collision-catgeory(top-collider, main-collision-category)
    MATTER.set-collision-catgeory(bottom-collider, main-collision-category)
    MATTER.set-collision-mask(top-collider, main-collision-category)
    MATTER.set-collision-mask(bottom-collider, main-collision-category)
    MATTER.add-to-world(engine, [L.list: bottom-collider, top-collider])

  end

end

shadow player = player()
shadow ground = ground()

text = DOM.get-element("distance")

context = {
  to-update: [L.list: player],
  player: player,
  camera: camera
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

    THREE.set-pos-x(context.camera, player-pos.x)

    if I.query-input().space:
      block:
        MATTER.set-velocity(context.player.col, x-velocity, 0 - flap-y-velocity)
      end
    else:
      nothing
    end

  end

end

obstacle(400, 0)

MATTER.run-engine(runner, engine)

A.animate(renderer, scene, camera, animator, context)
