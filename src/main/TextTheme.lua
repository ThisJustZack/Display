local Package = script.Parent;

local TextStyle = require(Package.TextStyle);

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

local function new()
	local self = setmetatable({}, CLASS_METATABLE);

	self.bodySmall = TextStyle(Enum.Font.Roboto, 12, 16);
	self.bodyMedium = TextStyle(Enum.Font.Roboto, 14, 20);
	self.bodyLarge = TextStyle(Enum.Font.Roboto, 16, 24);
	
	self.labelSmall = TextStyle(Enum.Font.Roboto, 11, 16);
	self.labelMedium = TextStyle(Enum.Font.Roboto, 12, 16);
	self.labelLarge = TextStyle(Enum.Font.Roboto, 14, 20);
	
	self.titleSmall = TextStyle(Enum.Font.Roboto, 14, 20);
	self.titleMedium = TextStyle(Enum.Font.Roboto, 16, 24);
	self.titleLarge = TextStyle(Enum.Font.Roboto, 22, 28);
	
	self.headlineSmall = TextStyle(Enum.Font.Roboto, 24, 32);
	self.headlineMedium = TextStyle(Enum.Font.Roboto, 28, 36);
	self.headlineLarge = TextStyle(Enum.Font.Roboto, 32, 40);
	
	self.displaySmall = TextStyle(Enum.Font.Roboto, 36, 44);
	self.displayMedium = TextStyle(Enum.Font.Roboto, 45, 52);
	self.displayLarge = TextStyle(Enum.Font.Roboto, 57, 64);

	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
})