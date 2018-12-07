import list as L

import js-file("bindings/pythree") as THREE
import js-file("bindings/pymatter") as MATTER
import js-file("ecs/component-store") as CS
import js-file("ecs/uuid") as U
import js-file("animate") as A

# World init
scene = THREE.scene()
camera = THREE.perspective-camera-default()
renderer = THREE.web-gl-renderer-default()

THREE.set-pos-z(camera, 600)

engine = MATTER.create-engine()
runner = MATTER.create-runner()

context = {
  to-update: [L.list: ],
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


A.animate(renderer, scene, camera, animator, context)
