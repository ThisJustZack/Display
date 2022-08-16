local Package = script.Parent;

local New = require(Package.Parent.Instances.New);

--[[
	@class Page
	@client

	An immutable description of the configuration for a route's user interface.
]]--
local CLASS_METHODS = {};
local CLASS_METATABLE = {__index = CLASS_METHODS};
local CLASS_CONSTRUCTORS = {};

function CLASS_METHODS:build(context)
	return New "Frame" {
		Size = UDim2.fromScale(1, 1);
		Position = UDim2.fromScale(0, 0);
		BorderSizePixel = 0;
		BackgroundTransparency = 0;
	}
end

local function new()	
	return setmetatable({}, CLASS_METATABLE);
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new();
	end,
});