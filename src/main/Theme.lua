local Package = script.Parent;

local ThemeData = require(Package.ThemeData);
local ColorScheme = require(Package.ColorScheme);
local TextTheme = require(Package.TextTheme);

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

local function new(colorScheme, textTheme)
	local self = setmetatable({}, CLASS_METATABLE);

	self.data = ThemeData(colorScheme, textTheme);

	return self;
end

function CLASS_CONSTRUCTORS.of(context)
	return context.theme.data;
end

function CLASS_CONSTRUCTORS.dark()	
	local scheme = ColorScheme(Color3.fromHex("#bb86fc"), Color3.fromHex("#03dac6"), Color3.fromHex("#cf6679"), Color3.fromHex("#121212"), true)
	return new(scheme, TextTheme());
end

function CLASS_CONSTRUCTORS.fallback()
	return CLASS_CONSTRUCTORS.light();
end

function CLASS_CONSTRUCTORS.light()	
	local scheme = ColorScheme(Color3.fromHex("#2196f3"), Color3.fromHex("#2196f3"), Color3.fromHex("#d32f2f"), Color3.fromHex("#ffffff"), false);
	return new(scheme, TextTheme());
end

function CLASS_CONSTRUCTORS.from(colorScheme, textTheme)
	return new(colorScheme, textTheme);
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return cls.from(...);
	end,
})