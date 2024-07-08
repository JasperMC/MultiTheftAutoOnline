-- Personal Vehicle Class
PersonalVehicle = {
    id,
    name,
    owner,
    model,
    variant1,
    variant2,
    color,
    headlight_color,
    license_plate
    insured,
    available,
    available_reason
}

function PersonalVehicle.new( self, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function PersonalVehicle.Spawn(self, position, rotation, interior, dimension )
    v = createVehicle( self.model, position.x, position.y, position.z, rotation.x, rotation.y, rotation.z, self.license_plate, self.variant1, self.variant2)
    v:setDimension( dimension )
    v:setInterior( interior )
    v:setColor(self.color)
    v:setHeadLightColor(self.headlight_color)
    self.element = v
    return v
end

function PersonalVehicle.UpdateFromElement(self, element )
    if not element and self.element then element = self.element end
    self.model = element:getModel()
    self.variant1, self.variant2 = element:getVariant()
    if not self.name then 
        self.name = element:getNameFromModel()
    end
    self.color = element:getColor()
    self.headlight_color = element:getHeadLightColor()
end

function PersonalVehicle.Destroy(self)
    if self.element then
        self.element = nil
        return destroyElement( self.element )
    end
end

-- Ownership
function PersonalVehicle.getOwner(self)

end

function PersonalVehicle.setOwner(self, owner )

end

function PersonalVehicle.transferOwnership(self, to_owner )

end

function PersonalVehicle.isOwnedByPlayer(self, player)

end

-- Spawn Data