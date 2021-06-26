isPluginActive = false
isMicActive = false
isMicEnabled = false

-- Event that check the status of the ts3 plugin
AddEventHandler('SaltyChat_PluginStateChanged', function(pluginState)
    if(pluginState == 2 or pluginState == 3) then
        isPluginActive = true
    else
        isPluginActive = false
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

-- Event that check if a player microphone is enabled or not
AddEventHandler('SaltyChat_MicEnabledChanged', function(isMicrophoneEnabled)
    if(isMicrophoneEnabled) then
        isMicEnabled = true
    else
        isMicEnabled = false
    end

    SendNUIMessage({
        action = "updateValues",
        isMicEnabledStatus = isMicEnabled
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if(isPluginActive and isMicActive and isMicEnabled) then
            SendNUIMessage({
                action = "setWindow",
                value = false
            })

            EnableAllControlActions(0)
        elseif(not isPluginActive or not isMicActive or not isMicEnabled) then
            SendNUIMessage({
                action = "setWindow",
                value = true
            })

            DisableAllControlActions(0)
        end
    end
end)
