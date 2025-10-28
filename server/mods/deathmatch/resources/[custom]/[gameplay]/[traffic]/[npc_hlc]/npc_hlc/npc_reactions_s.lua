npc_reactions = {
    ["default"] = {}
}
    
npc_reactions["default"]["onPedHijackedFromVehicle"] = 
    function ( ped, vehicle, seat, jacker )
        print("Triggered function onpedHijackedfromVehicle")
        if getPedWeapon(jacker) == 0 then
            -- Try and steal car back
            clearNPCTasks(ped)
            setNPCTask( ped, {"enterVehicle", vehicle, seat } )
        else
            -- Run away in panic
        end
    end

npc_reactions["default"]["onPedVehicleHijacked"] =
    function( ped, vehicle, seat, jacker )
        clearNPCTasks(ped)
        addNPCTask(ped, {"waitForVehicleToStop", vehicle })
        addNPCTask(ped, {"exitVehicle", vehicle})
    end


-- Default NPC Reactions
