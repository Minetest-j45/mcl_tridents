local S = minetest.get_translator("mcl_tridents")

local GRAVITY = 9.81

local TRIDENT_ENTITY = {
	physical = true,
	pointable = false,
	visual = "mesh",
	mesh = "mcl_trident.obj",
	visual_size = {x=-1, y=1},
	textures = {"mcl_trident.png"},
	collisionbox = {-0.19, -0.125, -0.19, 0.19, 0.125, 0.19},
	collide_with_objects = false,
	_fire_damage_resistant = true,

	_lastpos={},
	_startpos=nil,
	_damage=1,	-- Damage on impact
	_is_critical=false, -- Whether this arrow would deal critical damage
	_stuck=false,   -- Whether arrow is stuck
	_stucktimer=nil,-- Amount of time (in seconds) the arrow has been stuck so far
	_stuckrechecktimer=nil,-- An additional timer for periodically re-checking the stuck status of an arrow
	_stuckin=nil,	--Position of node in which arow is stuck.
	_shooter=nil,	-- ObjectRef of player or mob who shot it

	_viscosity=0,   -- Viscosity of node the arrow is currently in
	_deflection_cooloff=0, -- Cooloff timer after an arrow deflection, to prevent many deflections in quick succession
}




minetest.register_entity("mcl_tridents:trident_entity", TRIDENT_ENTITY)

minetest.register_craftitem("mcl_tridents:trident", {
	description = S("Trident"),
	inventory_image = "mcl_trident_inv.png",
	groups = {},
    on_use = function(itemstack, user, pointed_thing)
      local obj = minetest.add_entity(vector.add(user:get_pos(), {x = 0, y = 1.5, z = 0}), "mcl_tridents:trident_entity")
      local yaw = user:get_look_horizontal()+math.pi/2
      if obj then
         obj:set_velocity(vector.multiply(user:get_look_dir(), 20))
         obj:set_acceleration({x=0, y=-GRAVITY, z=0})
         obj:set_yaw(yaw)
      end
  end
})
