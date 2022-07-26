local Package = script.Parent;

local Theme = require(Package.Theme);
local Locale = require(Package.Locale);
local Navigator = require(Package.Navigator);

local New = require(Package.Parent.Instances.New);

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

function class:build(context)
	local theme = Theme.of(context);
	local navigator = Navigator.of(context);
	local locale = Locale.of(context);
	local uniStates = context.states;
	
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