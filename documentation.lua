--[[
    SL - SettingsLibary
    Made by Sinox
    Documentation
]]

--First we need to import the request library
--we use local 'nameyouwanttohave' = loadstring(game:HttpGet(url))()

local Lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/Sino1507/SL/main/src.lua'))()


--Using Lib:new to create our first setting.

--Arguments for Lib:new are:
--Lib:new(name, content, version)
--Needed are name and content, version is optional.
--The content needs to be a table for example {1 = "Hello", 2 = "World"}
--Example:

Lib:new('Saved', {killaura = false, killaura_key = 'K'}, '1.0.0')

--This would save a setting called 'Saved' with the content {killaura = false, killaura_key = 'K'} and version 1.0.0.

--Now we can access the setting with Lib:read('Saved')
--This tool will return us our saved settings.
--Example:

local settings = Lib:read('Saved')

local killaura = nil

if settings then
    killaura = settings.killaura
end

print(killaura, settings.killaura_key)

--This would print out the value of killaura (this would be false) and the key of the killaura_key (this would be 'K')

--If you want to change the settings you can do this:
--Lib:overwrite(name, new_content, new_version)
--name and new_content are needed, new_version is optional.
--Example:

Lib:overwrite('Saved', {killaura = true, killaura_key = 'K'}, '1.0.1')

local read = Lib:read('Saved')

print(read.killaura)

--Now it would return true.

--If you want to delete a setting you can do this:
--Lib:delete(name)
--name is needed.
--Example:

Lib:delete('Saved')

local read = Lib:read('Saved')

print(read.killaura)

--This would return undefined because we just deleted the whole setting called 'Saved'.

--I know this Lib isn't the best but it is my first and i think it still helps to be faster with saving data.
