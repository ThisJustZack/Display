local Package = script.Parent;

local Color = require(Package.Utility.Color);
local ColourUtils = require(Package.Utility.ColourUtils);

local schemeFromColors = Color.schemeFromColors;

local State = require(Package.Parent.Core.Value);
local Computed = require(Package.Parent.Core.Computed);

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

function class:update(primary: Color3, secondary: Color3, error: Color3, neutral: Color3, tertiary: Color3?)
	self.primary:set(primary);
	self.secondary:set(secondary);
	self.tertiary:set(tertiary);
	self.error:set(error);
	self.neutral:set(neutral);
end

local function new(primary: Color3, secondary: Color3, error: Color3, neutral: Color3, tertiary: Color3?)
	local self = setmetatable({}, CLASS_METATABLE);
	
	self.primary = State(primary);
	self.secondary = State(secondary);
	self.tertiary = State(tertiary);
	self.error = State(error);
	self.neutral = State(neutral);
	self.isDark = Computed(function()
		return ColourUtils.isDark(self.neutral:get());
	end);
	
	self.colors = Computed(function()
		return schemeFromColors(self.primary:get(), self.secondary:get(), self.error:get(), self.neutral:get(), self.isDark:get(), self.tertiary:get());
	end);
	
	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
});