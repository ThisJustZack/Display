local class = {};

local CLASS_METATABLE = {__index = class};
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