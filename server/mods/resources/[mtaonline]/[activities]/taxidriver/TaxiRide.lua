TaxiRide = {
    driver,
    expected_passengers,
    passengers,
    destination,
    max_damage,
    damage_taken,
    requested_by
    distance_traveled
    timer
}

function TaxiRide.onPassengerPickup( self, passenger )

    -- Even better, if self.expected_passengers = self.passengers then
    if len(self.expected_passengers) == len(self.passengers) then
        -- Generate destination marker with blip
    end
end

function TaxiRide.onPassengerLeave( self, passenger, reason )

end

function TaxiRide.onDestinationReached( self )

end

function TaxiRide.onTimerEnds( self )

end

function TaxiRide.onVehicleDamage( self )

end

function TaxiRide.createDestinationMarker()

end