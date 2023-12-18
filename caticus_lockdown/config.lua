Config = {}


-- Jobs allowed to use the Closure functionality
-- Add the names of the jobs that are allowed to use the Closure
Config.AllowedJobs = { "ambulance", "police", "fbi", 'sheriff' }
 
-- Maximum number of lockdown blips on the map
Config.MaxLockdown = 30
 
-- The maximal Closure radius (in meters)
Config.MaxLockdownSize = 300
 
-- Default Closure radius (in meters)
Config.DefaultRadius = 200
 

 
-- Closure-related commands
Config.CloseCommand = 'lock' -- Closure command
Config.UnlockCommand = 'unlock' -- Unlock command
 
-- Icons for the Closure blips
-- You can find more icons here: https://docs.fivem.net/docs/game-references/blips/
Config.BlipIcons = {
    ["ambulance"] = 153,
    ["police"] = 526,
    ["sheriff"] = 58,
    ["fbi"] = 60
}
 
-- Colors for the Closure blips
-- You can find more colors here: https://docs.fivem.net/docs/game-references/blips/
Config.BlipColors = {
    ["ambulance"] = 1,
    ["police"] = 3,
    ["sheriff"] = 5,
    ["fbi"] = 26
}
 
-- Texts for each type of Closure
Config.LockdownTexts = {
    ["ambulance"] = "Emergency Closure",
    ["police"] = "Police Closure",
    ["sheriff"] = "Sheriff Closure",
    ["fbi"] = "Investigation"
}