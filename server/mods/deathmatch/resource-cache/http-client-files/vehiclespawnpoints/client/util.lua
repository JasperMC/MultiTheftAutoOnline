addCommandHandler("vloc", 
    function()
        local v = getPedOccupiedVehicle( localPlayer ) 
        elementLocationToString( v, "map")
    end
)

function elementLocationToString( element, format )
    local x,y,z = getElementPosition( element )
    local rx,ry,rz = getElementRotation(element)
    local interior = getElementInterior(element)
    local dimension = getElementDimension(element)

    if format == "map" then
        outputChatBox( 'posX="' .. tostring(x) .. '" posY="' .. tostring(y) .. '" posZ="' .. tostring(z) .. '" rotX="' .. tostring(rx) .. '" rotY="' .. tostring(ry) .. '" rotZ="' .. tostring(rz) .. '" interior="' .. tostring(interior) .. '" dimension="' .. tostring(dimension) .. '"')
    end
end

addCommandHandler("showcol",
function()
    showCol (not isShowCollisionsEnabled())
end
)
addCommandHandler("devmode",
    function()
        setDevelopmentMode(true)
    end
)