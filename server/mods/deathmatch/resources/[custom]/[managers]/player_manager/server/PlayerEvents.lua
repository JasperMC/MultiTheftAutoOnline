addEventHandler("onPlayerConnect", root,
    function()
    end
)

addEventHandler("onPlayerJoin", root,
    function()
        outputChatBox( "Welcome to #FF0000" .. getServerName() .. ", " .. RGBToHex(getPlayerNametagColor(source)) .. getPlayerName(source) .. "!", source, 255,255,255, true)
    end
)

addEventHandler("onPlayerQuit", root,
    function()

    end
)

addEventHandler("onPlayerDisconnect", root,
    function()
    
    end
)

addEvent("onPlayerRequestLogin", true)
addEventHandler("onPlayerRequestLogin", root,
    function(username, email, password)
        if username and password or email and password then
            options = {["method"] = "POST", ["headers"] = {["Content-Type"] = "application/json"}}
            options["postData"] = string.sub( toJSON( {['username'] = username, ['password'] = password } ), 3, -3)
            print("postData: '" .. options["postData"] .. "'")
            print('Got here 1')
            fetchRemote( "http://localhost:9191/player/login", options,
                function(responseData, responseInfo, source)
                    if responseInfo["statusCode"] == 200 then
                        print(responseData)
                        print(responseData[0])
                        print(fromJSON(responseData))
                        --for k,v in pairs(fromJSON(responseData)) do
                        --    print(k .. ": " .. v )
                        --end

                        logPlayerIn( source, fromJSON(responseData) )
                    else
                        print(responseInfo['statusCode'])
                        print(responseData)
                    end
                end, {source})
        end
    end
)

addCommandHandler("rlogin",
function(player, cmd, username, password)
    triggerEvent("onPlayerRequestLogin", player, username, nil, password)
end
)

addCommandHandler("rmodel",
    function(player, cmd, model )
        updatePlayer(player, {["model"] = model})
        setElementModel(player, model)
    end
)