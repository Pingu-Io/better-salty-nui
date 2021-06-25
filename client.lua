isPluginActive = false
isMicActive = false

-- Event that check the status of the ts3 plugin (-1=notActive, 0,1,2,3=active)
AddEventHandler('SaltyChat_PluginStateChanged', function(pluginState)
    if(pluginState == -1) then
        isPluginActive = false
    else
        isPluginActive = true
    end

    SendNUIMessage({
        action = "updateValues",
        isPluginActiveStatus = isPluginActive
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
        isMicActiveStatus = isMicActive
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
