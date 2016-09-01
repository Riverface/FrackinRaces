require("/scripts/vec2.lua")
function init()
  inWater=0
  effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "fumudslowImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "slimestickImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "waterbreathProtection", amount = 1}})
  effect.addStatModifierGroup({{stat = "wetImmunity", amount = 1}})
  
baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})

  script.setUpdateDelta(5)	
end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
	    status.removeEphemeralEffect("regenerationminor",math.huge)
            status.clearPersistentEffects("orcanaprotection")
            status.clearPersistentEffects("orcanaprotection2")
            status.clearPersistentEffects("orcanaprotection3")
            status.clearPersistentEffects("orcanaprotection4")
	    inWater = 0
	end
end

function update(dt)
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if world.liquidAt(mouthPosition) and inWater == 0 then
	    status.addEphemeralEffect("regenerationminor",math.huge)
            status.setPersistentEffects("orcanaprotection2", {{stat = "foodDelta", amount = -0.015}})
            status.setPersistentEffects("orcanaprotection4", {{stat = "fallDamageMultiplier", amount = 0.0}})
	    inWater = 1
	else
	  isDry()
        end  
end

function uninit()
              status.clearPersistentEffects("orcanaprotection")
              status.clearPersistentEffects("orcanaprotection2")
              status.clearPersistentEffects("orcanaprotection3")
            status.clearPersistentEffects("orcanaprotection4")
end