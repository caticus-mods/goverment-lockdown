local QBCore = exports['qb-core']:GetCoreObject()

local function CreateLockdownZone(job, coords)
    print("Creating lockdown zone for job: " .. job)

    -- Create the radius blip for the lockdown zone
    local testRadius = 100.0  -- Radius for the zone
    local radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, testRadius)
    SetBlipAlpha(radiusBlip, 200)  -- Visible alpha
    SetBlipColour(radiusBlip, Config.BlipColors[job] or 1)  -- Color based on the job
    SetBlipHighDetail(radiusBlip, true)

    -- Create a central blip for the lockdown zone
    local centralBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(centralBlip, Config.BlipIcons[job] or 60) -- Default to a generic icon if job icon is not found
    SetBlipColour(centralBlip, Config.BlipColors[job] or 1) -- Same color as the radius
    SetBlipScale(centralBlip, 1.0)
    SetBlipAsShortRange(centralBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.LockdownTexts[job] or "Lockdown Zone")
    EndTextCommandSetBlipName(centralBlip)

    print("Lockdown zone created at: " .. coords.x .. ", " .. coords.y .. ", " .. coords.z .. " with radius: " .. testRadius)

    return radiusBlip, centralBlip
end



-- Storage for active lockdown zones
local activeLockdownZones = {}

RegisterNetEvent('QBCore:Client:CreateLockdownBlip')
AddEventHandler('QBCore:Client:CreateLockdownBlip', function(job)
    -- Remove existing lockdown zone for this job, if it exists
    if activeLockdownZones[job] then
        RemoveBlip(activeLockdownZones[job].radiusBlip)
        RemoveBlip(activeLockdownZones[job].centralBlip)
        activeLockdownZones[job] = nil  -- Clear the reference
    end

    -- Get player's current coordinates
    local playerCoords = GetEntityCoords(PlayerPedId())
    -- Create a new lockdown zone at player's position
    local radiusBlip, centralBlip = CreateLockdownZone(job, playerCoords)
    -- Store the blip handles for future reference
    activeLockdownZones[job] = { radiusBlip = radiusBlip, centralBlip = centralBlip }
end)

RegisterNetEvent('QBCore:Client:RemoveLockdownBlip')
AddEventHandler('QBCore:Client:RemoveLockdownBlip', function(job)
    -- Check if there are active lockdown zones for this job
    if activeLockdownZones[job] then
        -- Remove the radius blip and central blip
        RemoveBlip(activeLockdownZones[job].radiusBlip)
        RemoveBlip(activeLockdownZones[job].centralBlip)
        -- Clear the stored reference
        activeLockdownZones[job] = nil
    end
end)