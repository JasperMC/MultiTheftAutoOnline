
addEventHandler("onVehicleEnter", root,
    function( ped, seat, jacked )
        --[[
        if ped then
            if getElementType(ped) == "ped" then
                if isNPCHLCEnabled( ped ) then

                end
            else

            end
        ]]
        if jacked then
            if getElementType(jacked) == "ped" then
                print("Triggered ped got jacked")
                if isHLCEnabled(jacked) then
                    npc_reactions["default"].onPedHijackedFromVehicle( jacked, source, seat, ped)
                end
            end

        for i, occupant in ipairs(getVehicleOccupants(source)) do
            if getElementType(occupant) == "ped" then
                if isHLCEnabled(occupant) then
                    npc_reactions["default"].onPedVehicleHijacked( occupant, source, seat, ped)
                end
            end
        end
        end
    end
)