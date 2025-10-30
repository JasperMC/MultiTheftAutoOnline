mapRootNode = false

function loadMap()
    mapRootNode = xmlLoadFile( "vehiclespawnpoints.map")
end

function saveMap()
    xmlSaveFile( mapRootNode )
end

function addNode( type, data, parent_node )
    local node = false
    if type == "city" then
        if not parent_node then parent_node = mapRootNode end
        node = xmlCreateChild( parent_node, "city")
        xmlNodeSetAttribute( node, "name", data["name"] )
    elseif type == "zone" then
        node = xmlCreateChild( parent_node, "zone")
        for k,v in pairs(data) do xmlNodeSetAttribute(node, k,v) end
    elseif type == "vehiclespawnpoint" then
        node = xmlCreateChild( parent_node, "vehiclespawnpoint")
        for k,v in pairs(data) do xmlNodeSetAttribute( node, k, v) end
    end
    return node
end

function findNode( type, name, parent_node )
    if type == "city" then
        if not parent_node then parent_node = mapRootNode end
        for i, city_node in ipairs(xmlNodeGetChildren(parent_node)) do
            if xmlNodeGetName(city_node) == "city" and xmlNodeGetAttribute(city_node, "name") == name then
                return city_node
            end
        end
        return false
    elseif type == "zone" then
        if parent_node then
            for i, zone_node in ipairs(xmlNodeGetChildren(parent_node)) do
                if xmlNodeGetName(zone_node) == "zone" and xmlNodeGetAttribute( zone_node, "name") == name then
                    return zone_node
                end
            end
            return false
        else
            for i, city_node in ipairs(xmlNodeGetChildren(parent_node)) do
                for j, zone_node in ipairs(xmlNodeGetChildren(city_node)) do
                    if xmlNodeGetName(zone_node) == "zone" and xmlNodeGetAttribute( zone_node, "name") == name then
                        return zone_node
                    end
                end
            end
            return false
        end
    end
end


function createVehicleSpawnpointFromVehicle( vehicle, data )
    local x,y,z = getElementPosition(vehicle)
    local rx,ry,rz = getElementRotation(vehicle)
    local i = getElementInterior(vehicle)
    local d = getElementDimension(vehicle)
    local zone_name = getZoneName( x, y, z)
    local city_name = getZoneName( x,y,z, true )
    local city_node = findNode("city", city_name)
    if not city_node then -- If the city does not exist, create it and create the zone (the zone would not exist either)
        city_node = addNode("city", {["name"] = city_name}, mapRootNode )
        zone_node = addNode("zone", {["name"] = zone_name}, city_node)
    else
        zone_node = findNode("zone", zone_name, city_node)
        if not zone_node then -- If  zone does not exist, create it
            zone_node = addNode("zone", {["name"] = zone_name}, city_node)
        end
    end

    local vdata = {
        ["posX"] = x,
        ["posY"] = y,
        ["posZ"] = z,
        ["rotX"] = rx,
        ["rotY"] = ry,
        ["rotZ"] = rz,
        ["interior"] = i,
        ["dimension"] = d,
    }
    for k,v in pairs(data) do vdata[k] = v end
    vehicle_spawnpointnode = addNode( "vehiclespawnpoint", vdata, zone_node )

    return vehicle_spawnpointnode
end

addEvent("onVehicleSpawnpointEditorSubmit", true)
addEventHandler("onVehicleSpawnpointEditorSubmit", root,
    function( data )
        outputChatBox("event triggered")
        local vehicle = getPedOccupiedVehicle(client)
        if vehicle then
            outputDebugString("vehicle found")
            if not mapRootNode then loadMap() end
            outputDebugString("creating spawnpoint")
            node = createVehicleSpawnpointFromVehicle( vehicle, data)

            if node then
                outputDebugString("spawnpoint created")
                saveMap()
                outputChatBox("Vehicle spawnpoint created", client, 0, 255, 0)
            end
        else
            outputChatBox("Not in a vehicle", client, 255,0,0)
        end
    end
)

addEvent("onEditorRequestMove", true)
addEventHandler("onEditorRequestMove", root,
    function(direction, stepsize, createV)
        if isPedInVehicle(client) then
            local vehicle = getPedOccupiedVehicle(client)
            local newPosition
            if direction == "left" then
                newPosition = vehicle.matrix:transformPosition( Vector3(-stepsize, 0, 0))
            else
                newPosition = vehicle.matrix:transformPosition( Vector3(stepsize, 0, 0))
            end
            vehicle.position = newPosition
        end
    end
)

addCommandHandler("spawninrow",
    function(player,cmd, number )
        if isElement(player) then
            if not number then number = 1 else number = tonumber(number) end
            local vehicle = getPedOccupiedVehicle(player)
            if vehicle then
                local model = getElementModel( vehicle )
                local matrix = vehicle.matrix
                for i = 1, number, 1 do
                    local newPosition = matrix:transformPosition( Vector3(3.75*i, 0, 0))
                    local v = createVehicle( model, newPosition, vehicle.rotation )
                end
            end
        end
    end
)



