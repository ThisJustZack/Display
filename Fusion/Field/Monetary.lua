--!nonstrict

--[[
	Constructs and returns objects which can be used to model independent
	reactive state.
]]

local Package = script.Parent
local useDependency = require(Package.Parent.Core.Dependencies.useDependency)
local initDependency = require(Package.Parent.Core.Dependencies.initDependency)
local isSimilar = require(Package.Parent.Core.Utility.isSimilar)
local updateAll = require(Package.Parent.Core.Dependencies.updateAll)

local class = {}

local CLASS_METATABLE = {__index = class}
local WEAK_KEYS_METATABLE = {__mode = "k"}

local NUMBER_SUFFIXES = {
	"K",
	"M",
	"B",
	"t",
	"q",
	"Q",
	"s",
	"S",
	"o",
	"n",
	"d",
	"U",
	"D",
	"T",
	"Qt",
	"Qd",
	"Sd",
	"St",
	"O",
	"N",
	"v",
	"c",
}

--[[
	Returns the value currently stored in this State object.
	The state object will be registered as a dependency unless `asDependency` is
	false.
]]
function class:get(asDependency: boolean?): any
	if asDependency ~= false then
		useDependency(self)
	end
	
	local formattedNumberSuffix = math.floor(math.log(self._value, 1e3))

	return if formattedNumberSuffix == -math.huge then 0 else ("%.2f"):format(self._value / math.pow(10, formattedNumberSuffix * 3)):gsub("%.?0+$", "")
		.. (NUMBER_SUFFIXES[formattedNumberSuffix] or "")
end

--[[
	Updates the value stored in this State object.

	If `force` is enabled, this will skip equality checks and always update the
	state object and any dependents - use this with care as this can lead to
	unnecessary updates.
]]
function class:set(newValue: number, force: boolean?)
	local similar = isSimilar(self._value, newValue)
	self._value = newValue

	-- if the value hasn't changed, no need to perform extra work here
	if not similar or force then
		-- update any derived state objects if necessary
		updateAll(self)
	end
end

local function Monetary(initialValue: number)
	local self = setmetatable({
		type = "State",
		kind = "Monetary",
		-- if we held strong references to the dependents, then they wouldn't be
		-- able to get garbage collected when they fall out of scope
		dependentSet = setmetatable({}, WEAK_KEYS_METATABLE),
		_value = initialValue
	}, CLASS_METATABLE)

	initDependency(self)

	return self
end

return Monetary