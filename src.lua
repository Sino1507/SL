--[[
    Script made by Sinox
]]

local FILE_EXTENSION = ".txt"

local version = isfile('SLV'..FILE_EXTENSION) and readfile('SLV'..FILE_EXTENSION) or '0.0.0'
local git = 'https://github.com/Sino1507/SL/tree/main/'
local rgit = 'https://raw.githubusercontent.com/Sino1507/SL/main/'

local SUPPORTED_EXPLOIT = syn and syn.request or request 

if not SUPPORTED_EXPLOIT then
    print('[SL] Exploit not supported')
    game.Players.LocalPlayer:Kick('[SL] Exploit not supported')
end


function _getContent(url)
    local method = 'GET'
    local url = url or ''

    local REQUEST = syn.request or request

    local res = REQUEST({
        Url = url,
        Method = method
    })

    if res['StatusCode'] == 200 then
        return res.Body
    else
        return false
    end
end


function _getVersion()
    local url = rgit..'SLV'..FILE_EXTENSION
    local content = _getContent(url)

    if content then
        return content
    else
        return false
    end
end

function _overwriteversion(version, gversion)
    local file = 'SLV'..FILE_EXTENSION
    local content = version
    local gcontent = gversion

    if gcontent then
        content = gcontent
    end

    writefile(file, content)
end

_overwriteversion(version, _getVersion())

local Lib = {}
Lib.__index = Lib

print('[SL] Version: '..readfile('SLV'..FILE_EXTENSION))
print('[SL] Git: '..git)
print('[SL] Created by Sinox')
print('\n')


function _checkgit(url)
    --Check if the url is a github link or a raw github link
    local url = url or ''

    local VALID_GIT_URL = nil

    if string.find(url, 'github.com') then
        VALID_GIT_URL = true
    elseif string.find(url, 'raw.githubusercontent.com') then
        VALID_GIT_URL = true
    else
        VALID_GIT_URL = false
    end

    local VALID_CONTENT = nil

    --check if the content of the url isnt nothing and doesnt contains a link
    if _getContent(url) and not string.find(_getContent(url), '.com') then
        VALID_CONTENT = true
    else
        VALID_CONTENT = false
    end

    if VALID_GIT_URL and VALID_CONTENT then
        return true
    else
        return false
    end
end

function _createsetting(name, content, Version, Git)
    local file = name..FILE_EXTENSION or 'Untitled'..FILE_EXTENSION
    local content = content or ''
    local version = Version or '0.0.0'
    local git = Git
    
    if git and git ~= 'Not set' then
        if _checkgit(git) then
            content = _getContent(git)
        end
    end

    writefile(file, content)

    local VERSION_FILE = name..'V'..FILE_EXTENSION

    writefile(VERSION_FILE, version)
end

function Lib:new(Name, Content, Version, Git)
    local name = Name or 'Untitled'
    local content = Content or ''
    local version = Version or '0.0.0'
    local git = Git or 'Not set'

    _createsetting(name, content, version, git)
end

function Lib:delete(Name)
    local file = Name..FILE_EXTENSION or 'Untitled'..FILE_EXTENSION
    local version = Name..'V'..FILE_EXTENSION or 'Untitled'..'V'..FILE_EXTENSION

    if isfile(file) then
        delfile(file)
    end

    if isfile(version) then
        delfile(version)
    end
end


function _jdecode(str)
    local decode = game:GetService("HttpService"):JSONDecode(str)
    return decode
end

function _jencode(str)
    local encode = game:GetService("HttpService"):JSONEncode(str)
    return encode
end

function Lib:overwrite(Name, Overwrite, Git, NewVersion)
    local file = Name..FILE_EXTENSION or 'Untitled'..FILE_EXTENSION
    local version = Name..'V'..FILE_EXTENSION or 'Untitled'..'V'..FILE_EXTENSION

    if isfile(file) then
        local content = readfile(file)
        local vcontent = readfile(version)

        if Overwrite then
            local content = Overwrite
            local git = Git or 'Not set'

            if git and git ~= 'Not set' then
                if _checkgit(git) then
                    content = _getContent(git)
                end
            end

            writefile(file, content)
        end
        if NewVersion then
            local newversion = NewVersion
            writefile(version, newversion)
        end
    end
end


function _readsettings(name)
    local file = name..FILE_EXTENSION or 'Untitled'..FILE_EXTENSION

    if isfile(file) then
        local content = readfile(file)
        local encode = _jencode(content)

        return encode
    else
        print('[SL] File not found')
    end
end

function Lib:read(name)
    local setting = _readsettings(name)

    return setting
end

return Lib
