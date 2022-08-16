--[[
	@class BuildContext
	@client

	A handle to the location of a widget in the widget tree, commonly used in the build method of widgets.
]]--
local CLASS_METHODS = {};
local CLASS_METATABLE = {__index = CLASS_METHODS};
local CLASS_CONSTRUCTORS = {};

local function new(navigator, theme, locale, states, deviceInformation)
	local self = setmetatable({}, CLASS_METATABLE)

	self.navigator = navigator;
	self.theme = theme;
	self.locale = locale;
	self.states = states;
	self.deviceInformation = deviceInformation;
	
	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
});