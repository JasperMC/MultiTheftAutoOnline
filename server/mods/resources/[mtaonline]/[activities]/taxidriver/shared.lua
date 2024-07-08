
function isVehicleATaxi( vehicle )
    local model = getElementModel(vehicle)
    return model in {420,586}
end

function isPlayerDrivingATaxi( player )
    local vehicle = getPedOccupiedVehicle( player )
    return getVehicleController(vehicle) == player and isVehicleATaxi(vehicle)
end

function isPlayerInATaxi( player )
    local vehicle = getPedOccupiedVehicle( player )
    return isVehicleATaxi(vehicle)
end