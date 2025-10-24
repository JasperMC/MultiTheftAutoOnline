--[[
    Player Functions

    Description: Player Functions
]]

function isPlayerLoggedIn(player)
    local id = getElementData(player, "player_manager:id")
    return id ~= false, id
end

function logPlayerIn( player, data )
    if isElement(player) and data then
        setElementData( player, 'player_manager:id', '_id')
        setPlayerName( player, data['username'])
        setElementModel( player, data['model'])
        setPlayerMoney( player, data['cash'])

    end
end

function updatePlayer( player, data )
    if isElement(player) and data then
        local isLoggedIn, id = isPlayerLoggedIn(player)
        if isLoggedIn then
            options = {["method"] = "PATCH", ["headers"] = {["Content-Type"] = "application/json"}}
            options["postData"] = string.sub( toJSON( data ), 3, -3)
            fetchRemote( "http://localhost:9191/player/" .. id , options,
                function(responseData, responseInfo, player)
                    if responseInfo["statusCode"] == 200 then
                            print(responseInfo['statusCode'])
                            print(responseData)
                        end
                    end, {player})
        end
    end 
end


-- Override
function givePlayerWeapon(player, weapon, ammo )

end

