addEvent("onPlayerTaxiActivityStart")
addEvent("onPlayerTaxiRideComplete")
addEvent("onPlayerTaxiRideFail")
addEvent("onPlayerTaxiActivityStop")

TaxiManager = {
    drivers = {}
    requests = {}
}

function TaxiManager.promptPlayerToBecomeDriver( self, player )
    Dispatch.Dialogue( 'driver_prompt', nil, player)
end

function TaxiManager.onPressTaxiBind( self, player )
    if not self.isPlayerATaxiDriver( player ) then
        if isPlayerDrivingATaxi(player) then
            self.addDriver(player)
            Dispatch.Dialogue( 'activity_start', nil, player)
        else
            self.removeDriver(player)
            Dispatch.Dialogue( 'activity_stop', nil, player)
        end
end

function TaxiManager.addDriver( self, driver )
    self.drivers[driver] = {
        number_of_successful_rides = 0,
        number_of_failed_rides = 0,
        current_ride = false
    }
end

function TaxiManager.removeDriver( self, driver )
    TaxiManager.drivers[driver] = nil
end

function TaxiManager.isPlayerATaxiDriver( self, player )
    for driver, data in pairs(self.drivers)
        if driver == player then
            return true
        end
    end

    return false
end

function TaxiManager.Announce(self, msg)
    Dispatch.Say(msg, self.drivers)
end

function TaxiManager.onPlayerRequestTaxiRide(self, player, taxiride)
    if #self.drivers != 0 then
        self.requests[player] = taxiride
        self.Announce("Player " .. getPlayerColor(player) .. getPlayerName(player) .. " requested a taxi ride. Type /accept to accept")
        addCommandHandler('accept', self.onDriverAcceptPlayerTaxiRideRequest)
        outputChatBox("Your request has been announced to nearby taxi drivers", player, 0,255,0)
    else
        outputChatBox("There are currently no taxi drivers available.", player, 255, 0, 0)
    end
end

function TaxiManager.onDriverAcceptPlayerTaxiRideRequest(self, player, taxiride)
    if isPlayerATaxiDriver(player) then
        removeCommandHandler("accept", self.onDriverAcceptPlayerTaxiRideRequest)
        Dispatch.Say(getPlayerName(player) .. " accepted the request")

    end
end

taxiManager = TaxiManager()