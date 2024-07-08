addEvent("onVehicleCustomUpgradeAdded")
addEvent("onVehicleCustomUpgradeRemoved")


function addCustomVehicleUpgrade( vehicle, upgrade )
    addCustomVehicleUpgrades( vehicle, { upgrade })
end

function addCustomVehicleUpgrades( vehicle, upgrades)
    local c_upgrades = getCustomVehicleUpgrades( vehicle ) or {}
    for i,v in ipairs(upgrades) do
        table.insert(c_upgrades, v)
    end
    setElementData( vehicle, 'custom_upgrades', c_upgrades)
end

function removeCustomVehicleUpgrade( vehicle, upgrade )
    return removeAllCustomVehicleUpgrades( vehicle, { upgrade })
end

function removeCustomVehicleUpgrades( vehicle, upgrades )
    local c_upgrades = getCustomVehicleUpgrades( vehicle )
    if c_upgrades then
        for idx, upgrade in ipairs(upgrades) do 
            for i,v in ipairs(c_upgrades) do
                if v == upgrade then
                    c_upgrades[i] = nil
                end
            end
        end

        return setElementData( vehicle, 'custom_upgrades', c_upgrades)
    end
end

function removeAllCustomVehicleUpgrades( vehicle )
    removeElementData( vehicle, 'custom_upgrades')
end