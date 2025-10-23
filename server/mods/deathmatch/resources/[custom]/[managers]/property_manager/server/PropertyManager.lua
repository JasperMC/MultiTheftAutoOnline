
PropertyManager = [

]

function PropertyManager.Start()
    mapNode = xmlLoadFile( "properties.map")
    mapRoot = loadMapData( mapNode )
end

function PropertyManager.Stop()

end

addEventHandler("onResourceStart", resourceRoot, PropertyManager.Start)
addEventHandler("onResourceStop", resourceRoot, PropertyManager.Stop)
