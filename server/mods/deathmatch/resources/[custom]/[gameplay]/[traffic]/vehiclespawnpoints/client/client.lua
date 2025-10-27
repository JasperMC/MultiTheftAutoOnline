--[[
    Vehicle Spawnpoints
    File: client.lua
    Type: Client
    Description: Main script file
]]
render_distance = 1000

--[[
addEventHandler("onClientStreamIn", root,
    function()
        if getElementType(source) == "vehiclespawnpoint" and isElementSyncer(source) then
            if not getElementData(source, "occupied") then
                triggerServerEvent("onPlayerNearVehicleSpawnpoint", localPlayer, source)
            end
        end
    end
)
    ]]
--[[
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        setTimer(requestVehicleSpawnpoints, 5000, 0)
    end
)
]]

addEventHandler("onClientPreRender", root,
    function()
        requestVehicleSpawnpoints()
    end)



function requestVehicleSpawnpoints()
    local x, y, z = getElementPosition(localPlayer)
    local vehiclespawnpoints = getElementsByType("vehiclespawnpoint")
    local nearby_vehiclespawnpoints = {}
    for i, vehiclespawnpoint in ipairs(vehiclespawnpoints) do
        if not getElementData( vehiclespawnpoint, "occupied") and shouldVehicleSpawnpointVehicleBeCreated( vehiclespawnpoint ) then
            local vx, vy, vz = getElementPosition(vehiclespawnpoint)
            local distance = getDistanceBetweenPoints3D( x, y, z, vx, vy, vz )
            if distance <= render_distance then
                table.insert( nearby_vehiclespawnpoints, vehiclespawnpoint )
                
            end
        end
    end

    if #nearby_vehiclespawnpoints > 0 then
        outputDebugString("Close to parkingspots")
        triggerServerEvent("onPlayerNearVehicleSpawnpoints", localPlayer, nearby_vehiclespawnpoints)
    end
end