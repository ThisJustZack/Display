--!strict
local RunService = game:GetService("RunService")

if (RunService:IsServer()) then
	return {}
end

--[[
	The entry point for the Display library.
]]

local restrictRead = require(script.Parent.Core.Utility.restrictRead)

type Display = {
	-- version: PubTypes.Version,
	
	Application: {}, -- map to constructors
	BuildContext: {},
	ColorScheme: {},
	Device: {},
	Locale: {},
	Navigator: {},
	Page: {},
	Route: {},
	TextStyle: {},
	TextTheme: {},
	Theme: {},
	ThemeData: {}
}

return restrictRead("Display", {
	-- version = {major = 0, minor = 2, isRelease = false},
	
	Application = require(script.Application),
	BuildContext = require(script.BuildContext),
	ColorScheme = require(script.ColorScheme),
	Device = require(script.Device),
	Locale = require(script.Locale),
	Navigator = require(script.Navigator),
	Page = require(script.Page),
	Route = require(script.Route),
	TextStyle = require(script.TextStyle),
	TextTheme = require(script.TextTheme),
	Theme = require(script.Theme),
	ThemeData = require(script.ThemeData)
}) :: Display