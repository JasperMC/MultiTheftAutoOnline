--[[
    Function: Should Vehicle Spawnpoint Vehicle Be Created
    Description: Determines whether the vehicle should be spawned based on spawn type.
]]


-- Function: spawnVehicleSpawnpoint
-- Renders vehicle spawnpoint
function spawnVehicleSpawnpoint( vehiclespawnpoint )
    local x,y,z = getElementPosition( vehiclespawnpoint )
    local rx, ry, rz = tonumber(getElementData( vehiclespawnpoint, "rotX" )), tonumber(getElementData( vehiclespawnpoint, "rotY" )), tonumber(getElementData( vehiclespawnpoint, "rotZ" ))
    local colWidth = getElementData(vehiclespawnpoint, "colWidth" ) or 7
    local colHeight = getElementData(vehiclespawnpoint, "colHeight") or 3
    local colDepth = getElementData( vehiclespawnpoint, "colDepth") or 3.9
    m = vehiclespawnpoint.matrix
    local colPos = m:transformPosition( Vector3(-4, -2, -0.6) )
    --y = y - 0.8
    local colshape = createColCuboid( colPos.x, colPos.y, colPos.z, colWidth, colDepth, colHeight )
    setElementParent( colshape, vehiclespawnpoint )

end

function spawnVehicleSpawnpointVehicle( vehiclespawnpoint )
    local x, y, z = getElementPosition( vehiclespawnpoint )
    local rx, ry, rz = tonumber(getElementData( vehiclespawnpoint, "rotX" )), tonumber(getElementData( vehiclespawnpoint, "rotY" )), tonumber(getElementData( vehiclespawnpoint, "rotZ" ))

    -- If rotation is allowed, use 50% chance on whether vehicle should be rotated
    if not getElementData(vehiclespawnpoint, "lock_rotation") then
        if math.random(1,2) == 1 then
            rz = rz + 180
        end
    end

    -- Determine model
    local model
    local group = getElementData( vehiclespawnpoint, "group" )
    local subgroup = getElementData( vehiclespawnpoint, "subgroup" )
    if group and subgroup then
        if vehicles[group][subgroup] then
            model = vehicles[group][subgroup][math.random(1, #vehicles[group][subgroup])]
        else
            model = 411
        end
    else
        model = 411
    end

    print("Creating model " .. tostring(model) .. " (" .. getVehicleNameFromModel(model) .. ") at " .. tostring(x) .. ", " .. tostring(y) .. ", " .. tostring(z) )
    print(" with rotation: " .. tostring(rx) .. ", " .. tostring(ry) .. ", " .. tostring(rz) )
    -- Create vehicle
    local vehicle = createVehicle( model, x, y, z, rx, ry, rz )
    --setElementPosition( vehicle, x, y, z + getElementDistanceFromCentreOfMassToBaseOfModel(vehicle) )
    setElementParent( vehicle, vehiclespawnpoint )
    -- Mark vehiclespawnpoint as occupied
    setElementData( vehiclespawnpoint, "occupied", true)

    return vehicle

end


-- Events
addEvent("onPlayerNearVehicleSpawnpoints", true)
addEventHandler("onPlayerNearVehicleSpawnpoints", root,
    function( vehiclespawnpoints )
        print(getPlayerName(source) .. " is near " .. tostring(#vehiclespawnpoints) .. " vehicle spawnpoints")
        for i, vehiclespawnpoint in ipairs(vehiclespawnpoints) do
            if shouldVehicleSpawnpointVehicleBeCreated( vehiclespawnpoint ) then
                print("Vehicle should be spawned!")
                spawnVehicleSpawnpointVehicle( vehiclespawnpoint )
            else
                print("Vehicle should not be spawned")
            end
        end
    end
)

addEventHandler("onResourceStart", resourceRoot,
function()
    --f = xmlLoadFile("vehiclespawnpoints.map")
    --m = loadMapData(f, resourceRoot)


    --[[
    for i, vehiclespawnpoint in ipairs(getElementsByType("vehiclespawnpoint")) do
        --spawnVehicleSpawnpoint( vehiclespawnpoint )
        spawnVehicleSpawnpointVehicle( vehiclespawnpoint )
    end
    ]]

end
)


--[[
-- Colshape events
addEventHandler("onColShapeHit", resourceRoot,
    function(hitElement, matchingDimension)
        if matchingDimension then
            local vehiclespawnpoint = getElementParent(source)
            if not getElementData( vehiclespawnpoint, "occupied") then
                setElementData( vehiclespawnpoint, "occupied", true)
                print("Parkingspot is now occupied")
            end
        end
    end
)

-- Colshape events
addEventHandler("onColShapeLeave", resourceRoot,
    function(hitElement, matchingDimension)
        if matchingDimension then
            local vehiclespawnpoint = getElementParent(source)
            if getElementData( vehiclespawnpoint, "occupied") and #getElementsWithinColShape(source) == 0 then
                removeElementData( vehiclespawnpoint, "occupied")
                print("Parkingspot is no longer occupied")
            end
        end
    end
)
]]