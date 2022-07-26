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

--[[
	Returns the value currently stored in this State object.
	The state object will be registered as a dependency unless `asDependency` is
	false.
]]
function class:get(asDependency: boolean?): any
	if asDependency ~= false then
		useDependency(self)
	end
	return self._value
end

--[[
	Updates the value stored in this State object.

	If `force` is enabled, this will skip equality checks and always update the
	state object and any dependents - use this with care as this can lead to
	unnecessary updates.
]]
function class:set(newValue: any, force: boolean?)
	if (not table.find(self._choices, newValue)) then
		return
	end

	local similar = isSimilar(self._value, newValue)

	self._value = newValue

	-- if the value hasn't changed, no need to perform extra work here
	if not similar or force then
		-- update any derived state objects if necessary
		updateAll(self)
	end
end

local function Choice<T>(choices: {T}, initialChoice: T?)
	if (#choices < 1) then
		error()
	end
	if (initialChoice) then
		if (not table.find(choices, initialChoice)) then
			error()
		end
	end

	local self = setmetatable({
		type = "State",
		kind = "Choice",
		-- if we held strong references to the dependents, then they wouldn't be
		-- able to get garbage collected when they fall out of scope
		dependentSet = setmetatable({}, WEAK_KEYS_METATABLE),
		_choices = choices,
		_value = if (initialChoice ~= nil) then initialChoice else choices[1]
	}, CLASS_METATABLE)

	initDependency(self)

	return self
end

return Choice