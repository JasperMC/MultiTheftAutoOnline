function freemodeSpawnPlayer( player, spawnpoint )
    local spawnpoint = spawnpoint or getRandomSpawnpoint( Spawnpoints["spawnpoint"] )
    exports.spawnmanager:spawnPlayerAtSpawnpoint( player, spawnpoint, false )
    fadeCamera(player,true)
    setCameraTarget(player,player)
end

function freemodeSpawnAllPlayers( spawnpoint )
    local spawnpoint = spawnpoint or getRandomSpawnpoint( Spawnpoints["spawnpoint"] )
    for i, player in ipairs(getElementsByType( "player" )) do
        freemodeSpawnPlayer( player, spawnpoint)
    end
end