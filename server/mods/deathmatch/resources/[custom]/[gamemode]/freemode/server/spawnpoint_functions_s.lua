--[[
  SpawnPoint Functions
]]

function getSpawnpointType( spawnpoint )
  return getElementData( spawnpoint, "type")
end

function getSpawnpointsByType( spawnpoints, type )
  spawnpoints_of_type = {}
  for i, spawnpoint in ipairs(spawnpoints) do
    if getSpawnpointType(spawnpoint) == type then
      spawnpoints_of_type.append(spawnpoint)
    end
  end
  return spawnpoints_of_type or false
end

function getClosestSpawnpoint( element, spawnpoints )
 local el_x, el_y, el_z = getElementPosition( element )
 local closest_spawnpoint = false
 local closest_distance = 9999
 for i, spawnpoint in ipairs(spawnpoints) do
   local s_x, s_y, s_z = getElementPosition( spawnpoint )
   local distance = getDistanceBetweenPoints3D( el_x, el_y, el_z, s_x, s_y, s_z )
   if distance < closest_distance then
     closest_spawnpoint = spawnpoint
     closest_distance = distance
   return closest_spawnpoint, closest_distance
end

