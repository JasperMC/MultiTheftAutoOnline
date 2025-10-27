--[[
    Parkingspot
    Type: Shared
    
]]

function spawnVehicleInParkingspot( parkingspot, vehicle )
    local x,y,z = getElementPosition(parkingspot)
    local rx,ry,rz = getElementRotation(parkingspot)

    -- If no vehicle is provided, generate one
    if not vehicle then

    end
    if not isElement(vehicle) then
        local model = vehicle
        local vehicle = createVehicle(model,x,y,z,rx,ry,rz)
    end
    setElementPosition( vehicle, x, y, z)
    setElementRotation( vehicle, rx, ry, rz)
end

function getParkingspotCompatibleVehicleModels( parkingspot )

end

function isParkingspotOccupied( parkingspot )

end

function findNearestAvailableParkingspot()

end

function getParkingspotCollisionShape( parkingspot )

end




