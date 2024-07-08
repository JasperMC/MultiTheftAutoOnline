-- List of upgrades
Upgrades = {}

-- Upgrade class
Upgrade = {
    id,
    short_name,
    name,
    description,
    price
    compatibility = {
        types,
        models
    }
}

function Upgrade.new(self, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Upgrade.fromXMLNode( self, node )
    o = self:new()
    o.id = xmlNodeGetAttribute(node, "id")
    o.short_name = xmlNodeGetAttribute(node,"short_name")
    o.name = xmlNodeGetAttribute(node, "name")
    o.price = float(xmlNodeGetAttribute(node,"price") )
    types = xmlNodeGetAttribute( node, "types")
    if types then 
        o.compatibility['types'] = types
    end

    models = xmlNodeGetAttribute( node, "models")

    if models then
        o.compatibility['models'] = models
    end

    return o
end

function Upgrade.isCompatibleWith( self, vehicle )
    type = getVehicleType( vehicle )
    model = getVehicleModel( vehicle )
    match_type = false
    match_model = false
    if #self.compatibility['types'] > 0 then
        match_type = type in self.compatibility['types']
    else
        match_type = true
    end

    if #self.compatibility['models'] > 0 then
        match_model = model in self.compatibility['models']
    else
        match_model = true
    end

    return match_type and match_model
end

function Upgrade.isAffordableByPlayer( self, player )
    local money = getPlayerMoney( player )
    return money >= self.price
end

-- Fallback functions, specific to each upgrade
function Upgrade.addToVehicle( self, vehicle )
    
end

function Upgrade.removeFromVehicle( self, vehicle )

end

-- Loading from XML
function loadVehicleUpgradesFromXML()
    rootNode = xmlLoadFile( 'upgrades.xml')
    for i, node in ipairs( xmlNodeGetChildren(rootNode) ) do
        o = Upgrade:fromXMLNode(node)
        table.insert(Upgrades, o.id, o)
    end
    xmlUnloadFile(rootNode)
end

-- Vehicle
function getCompatibleCustomVehicleUpgrades( vehicle )
    u = {}
    for id, upgrade in pairs(Upgrades) do
        if upgrade:isCompatibleWith(vehicle) then
            table.insert(u, upgrade)
        end
    end

    return u
end

function getAllVehicleUpgrades( vehicle )
    all_upgrades = {}
    standard_upgrades = getVehicleUpgrades( vehicle )
    custom_upgrades = getCustomVehiclesUpgrades( vehicle ) or {}
    for i,v in ipairs(standard_upgrades) do table.insert(all_upgrades,v) end
    for i,v in ipairs(custom_upgrades) do table.insert(all_upgrades,v) end
    return all_upgrades
end


function getCustomVehiclesUpgrades( vehicle )
    return getElementData( vehicle, 'custom_upgrades')
end

function doesVehicleHaveCustomUpgrades( vehicle )
    getCustomVehiclesUpgrades( vehicle ) ~= false
end

function doesVehicleHaveCustomUpgrade( vehicle, upgrade )
    upgrades = getCustomVehiclesUpgrades(vehicle)
    if upgrades then
        return upgrade in upgrades
    else
        return false
    end
end



