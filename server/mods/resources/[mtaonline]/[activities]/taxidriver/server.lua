addEventHandler("onPlayerVehicleEnter", root,
function(vehicle, seat)
    if seat == 0 and isVehicleATaxi(vehicle) then
        TaxiManager.promptPlayerToBecomeDriver(source)
    end
end
)

