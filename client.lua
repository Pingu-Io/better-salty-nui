isPluginActive = false
isMicActive = false

-- Event that check the status of the ts3 plugin (0=notActive, 1=active, 2=inGame, 3=inWissChannel)
AddEventHandler('SaltyChat_PluginStateChanged', function(pluginState)
    if(pluginState == 0) then
        isPluginActive = false
    else
        isPluginActive = true
    end

    SendNUIMessage({
        action = "updateValues",
        isPluginActive = isPluginActive
    })
end)

-- Event that check when a player turn on or off the microphone
AddEventHandler('SaltyChat_MicStateChanged', function(isMicrophoneMuted)
    if(not isMicrophoneMuted) then
        isMicActive = true
    else
        isMicActive = false
    end

    SendNUIMessage({
        action = "updateValues",
        isMicActive = isMicActive
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if(isPluginActive and isMicActive) then
            SendNUIMessage({
                action = "setWindow",
                value = true
            })

            EnableAllControlActions(0)
        elseif(not isPluginActive or not isMicActive) then
            SendNUIMessage({
                action = "setWindow",
                value = false
            })

            DisableAllControlActions(0)
        end
    end
end)
