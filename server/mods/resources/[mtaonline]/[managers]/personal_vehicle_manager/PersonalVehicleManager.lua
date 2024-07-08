-- Class definition
PersonalVehicleManager = {
    players = {}
    vehicles = {}
}

function PersonalVehicleManager.new( self, o )
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function PersonalVehicleManager.Start(self)
    self.players = {}
    self.vehicles = {}
end

function PersonalVehicleManager.Stop(self)
    for id, vehicle in pairs(vehicles) do
        -- Update from element
        -- Update vehicle in API
        vehicle:Destroy()
    end
end

function PersonalVehicleManager.Restart(self)
    self.Stop()
    self.Start()
end

-- Vehicle request functions
function PersonalVehicleManager.canVehiclesBeRequested(self)

end

function PersonalVehicleManager.handlePersonalVehicleRequest(self, player, vehicle)
    
end

-- Vehicle functions
function PersonalVehicleManager.addVehicleToList( self, vehicle )
    table.insert( self.vehicles, str(vehicle.id), vehicle)
end

function PersonalVehicleManager.removeVehicleFromList( self, vehicle )
    for id, vehicle in pairs(self.vehicles) do
        if id == str(vehicle.id) then
            self.vehicles[id] = nil
            break
        end
    end
end

function PersonalVehicleManager.destroyAllVehicles()
    for id, vehicle in pairs(self.vehicles) do
        vehicle:Destroy()
    end
end

-- Player functions
function PersonalVehicleManager.addPlayerToList( self, player)
    self.players[player] = {}
end

function PersonalVehicleManager.removePlayerFromList( self, player)
    self:destroyAllPlayerVehicles(player)
    self.players[player] = nil

end

function PersonalVehicleManager.destroyPlayerVehicles( player )
    if self.players[player] then
        for id, vehicle in pairs(self.players[player]) do
            vehicle:Destroy()
        end
    end
end

function PersonalVehicleManager.spawnPersonalVehicleForPlayer( player, method, vehicle )
    if not method then method = "player_position" end

    if method == "next_to" then

    elseif method == "player_position" then
        position = player:getPosition()
        rotation = player:getRotation()
        interior = player:getInterior()
        dimension = player:getDimension()
        el = vehicle:Spawn(position,rotation, interior, dimension)
        if el then
            return warpPedIntoVehicle(player, el), el
        else
            return false
        end
        
    end
end

-- Events
pvManager = false

addEventHandler("onResourceStart", resourceRoot,
function()
    pvManager = PersonalVehicleManager:new()
    pvManager:Start()
end
)

addEventHandler("onResourceStop", resourceRoot,
function()
    pvManager:Stop()
end
)

addEventHandler("onPlayerQuit", root,
function()
    pvManager:removePlayerFromList( source )
end
)

addEventHandler("onPlayerJoin", root,
function()
    pvManager:addPlayerToList( source )
end
)

