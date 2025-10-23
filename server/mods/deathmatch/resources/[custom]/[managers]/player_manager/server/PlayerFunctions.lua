--[[
    Player Functions

    Description: Player Functions
]]

function isPlayerLoggedIn(player)

end

function logPlayerIn( player, data )
    if isElement(player) and data then
        setElementData( player, 'player_manager:id', '_id')
        setPlayerName( player, data['username'])
        setElementModel( player, data['model'])
        setPlayerMoney( player, data['cash'])

    end
end


-- Override
function givePlayerWeapon(player, weapon, ammo )

end

