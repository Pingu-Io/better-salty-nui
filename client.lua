isPluginActive = nil
isMicActive = nil

-- Event that check the status of the ts3 plugin
AddEventHandler('SaltyChat_PluginStateChanged', function(pluginState)
    if(pluginState == 2 or pluginState == 3) then
        isPluginActive = true
    else
        isPluginActive = false
    end

    SendNUIMessage({
        action = "updateValues",
        statusType = "isPluginActiveStatus",
        value = isPluginActive
    })
end)

-- Event that check when a player turn on or off the microphone
AddEventHandler('SaltyChat_MicStateChanged', function(isMicrophoneMuted)
    if(isMicrophoneMuted) then
        isMicActive = false
    else
        isMicActive = true
    end

    SendNUIMessage({
        action = "updateValues",
        statusType = "isMicActiveStatus",
        value = isMicActive
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if(isPluginActive and isMicActive) then
            SendNUIMessage({
                action = "setWindow",
                value = false
            })

            EnableAllControlActions(0)
        elseif(not isPluginActive or not isMicActive) then
            SendNUIMessage({
                action = "setWindow",
                value = true
            })

            DisableAllControlActions(0)
        end
    end
end)
