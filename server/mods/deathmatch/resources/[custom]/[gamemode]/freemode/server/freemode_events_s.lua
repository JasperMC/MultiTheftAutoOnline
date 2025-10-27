-- On Resource Start
addEventHandler("onResourceStart", resourceRoot,
    function()
    
    end
)

-- On Resource Stop
addEventHandler("onResourceStop", resourceRoot,
    function()
    
    end
)


-- On Gamemode Start
addEventHandler("onGamemodeMapStart", root, 
    function()

        -- Walk through all spawnpoints and keep in memory for later use.
        local spawnpoints = getElementsByType( "spawnpoint")
        Spawnpoints["hospital"] = getSpawnpointsByType( spawnpoints, "hospital" )
        Spawnpoints["police_station"] = getSpawnpointsByType( spawnpoints, "police_station" )
        for i, spawnpoint in ipairs(spawnpoints) do
            if not tablecontains( Spawnpoints["hospital"], spawnpoint) and not tablecontains( Spawnpoints["police_station"], spawnpoint) then
                table.insert(Spawnpoints["spawnpoints"], spawnpoint)
            end 
        end
    
        -- Spawn all players
        local spawnpoint = getRandomSpawnpoint( Spawnpoints["spawnpoints"] )
        Spawnpoints.initial_spawnpoint = spawnpoint
        freemodeSpawnAllPlayers( spawnpoint )
    end
)

addEventHandler("onGamemodeMapStop", resourceRoot,
    function()
    
    end
)




-- On Player join
addEventHandler("onPlayerJoin", root, 
    function()
        freemodeSpawnPlayer( source, Spawnpoints.initial_spawnpoint )
    end
)

-- On Player Login
addEventHandler("onPlayerLogin", root,
    function()
    end
)

-- On Player Spawn
addEventHandler("onPlayerSpawn", root,
    function()
        
    end
)

addEventHandler("onPlayerWasted", root,
    function()
        local spawnpoint = getClosestSpawnpoint( source, Spawnpoints["hospital"] )
        setTimer( freemodeSpawnPlayer, 5000, 1, source, spawnpoint )
    end
)

