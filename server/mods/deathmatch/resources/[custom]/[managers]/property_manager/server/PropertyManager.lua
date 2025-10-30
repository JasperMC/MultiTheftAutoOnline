
PropertyManager = [

]

function PropertyManager.Start()
end

function PropertyManager.Stop()

end

addEventHandler("onResourceStart", resourceRoot, PropertyManager.Start)
addEventHandler("onResourceStop", resourceRoot, PropertyManager.Stop)
