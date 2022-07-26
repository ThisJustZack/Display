--!strict

--[[
	The entry point for the Field library.
]]

local restrictRead = require(script.Parent.Core.Utility.restrictRead)

type Field = {
	-- version: PubTypes.Version,
	
	Choice: {},
	Monetary: {},
	Secret: {}
}

return restrictRead("Field", {
	-- version = {major = 0, minor = 2, isRelease = false},
	
	Choice = require(script.Choice),
	Monetary = require(script.Monetary),
	Secret = require(script.Secret)
}) :: Field