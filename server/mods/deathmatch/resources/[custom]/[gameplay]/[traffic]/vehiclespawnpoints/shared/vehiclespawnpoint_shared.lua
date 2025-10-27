function shouldVehicleSpawnpointVehicleBeCreated( vehiclespawnpoint )
    if getElementData(vehiclespawnpoint, "occupied") then return false end
    local spawn_type = getElementData(vehiclespawnpoint, "spawn_type")
    local spawn_data = getElementData(vehiclespawnpoint, "spawn_data")
    if spawn_type == "always" then
        return true
    elseif spawn_type == "chance" then
        return math.random(1, 1/tonumber(spawn_data)) == 1
    elseif spawn_type == "time" then
        local hours, minutes = getTime()

        local start_hours, start_minutes
        local end_hours, end_minutes
        return ( hours >= start_hours and minutes >= start_minutes ) and ( hours <= end_hour and minutes <= end_minutes )
    end
end