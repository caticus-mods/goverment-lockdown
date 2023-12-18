local QBCore = exports['qb-core']:GetCoreObject()

-- Helper function to check if a job is allowed
local function IsJobAllowed(job)
    for _, allowedJob in pairs(Config.AllowedJobs) do
        if job == allowedJob then
            return true
        end
    end
    return false
end

-- Command for creating a lockdown
QBCore.Commands.Add(Config.CloseCommand, "Create a lockdown blip", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player then
        local job = Player.PlayerData.job.name
        if IsJobAllowed(job) then
            -- Additional checks or functionality can be added here if needed
            TriggerClientEvent('QBCore:Client:CreateLockdownBlip', source, job)
        else
            TriggerClientEvent('QBCore:Notify', source, "You are not authorized to do this.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Player data not found.", "error")
    end
end)

-- Optional: Add server-side handling for unlocking
QBCore.Commands.Add(Config.UnlockCommand, "Remove the lockdown blip and zone", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player then
        local job = Player.PlayerData.job.name
        if IsJobAllowed(job) then
            TriggerClientEvent('QBCore:Client:RemoveLockdownBlip', source, job)
        else
            TriggerClientEvent('QBCore:Notify', source, "You are not authorized to do this.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Player data not found.", "error")
    end
end)
