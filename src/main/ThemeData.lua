local Package = script.Parent;

local Computed = require(Package.Parent.Core.Computed);

local Color = require(Package.Utility.Color);
local ColourUtils = require(Package.Utility.ColourUtils);

local getColorFromTone = Color.getColorFromTone;
local Tailwind = ColourUtils.Palette.Tailwind;

--[[
	@class ThemeData
	@client

	Defines the configuration of the overall visual Theme for a MaterialApp or a widget subtree within the app.
]]--
local CLASS_METHODS = {};
local CLASS_METATABLE = {__index = CLASS_METHODS};
local CLASS_CONSTRUCTORS = {};

local function new(colorScheme, textTheme)
	local self = setmetatable({}, CLASS_METATABLE);
	
	self.colorScheme = colorScheme;
	self.textTheme = textTheme;

	self.colors = Computed(function()
		local isDark = self.colorScheme.isDark:get();
		local background = self.colorScheme.colors:get()["background"];
		local surface = self.colorScheme.colors:get()["surface"];
		local primary = self.colorScheme.colors:get()["primary"];
		local onSurface = self.colorScheme.colors:get()["onSurface"];
		local onPrimary = self.colorScheme.colors:get()["onPrimary"];
		local primarySurfaceColor = if isDark then surface else primary;
		local onPrimarySurfaceColor = if isDark then onSurface else onPrimary;

		return {
			appBarColor = primarySurfaceColor;
			backgroundColor = background;
			canvasColor = background;
			cardColor = surface;
			dialogBackgroundColor = background;
			disabledColor = if isDark then getColorFromTone(Color3.fromHex("#ffffff"), 100-38) else getColorFromTone(Color3.fromRGB(), 38);
			dividerColor = if isDark then getColorFromTone(surface, 100-12) else getColorFromTone(surface, 12);
			errorColor = self.colorScheme.colors:get()["error"];
			focusColor = if isDark then getColorFromTone(Color3.fromRGB(), 100-12) else getColorFromTone(Color3.fromHex("#ffffff"), 12);
			highlightColor = if isDark then getColorFromTone(Color3.fromHex("#cccccc"), 100 - ((64/255) * 100)) else getColorFromTone(Color3.fromHex("#c8c8c8"), (102/255) * 100);
			hintColor = if isDark then getColorFromTone(Color3.fromRGB(), 100-60) else getColorFromTone(Color3.fromHex("#ffffff"), 60);
			hoverColor = if isDark then getColorFromTone(Color3.fromRGB(), 100-4) else getColorFromTone(Color3.fromHex("#ffffff"), 4);
			indicatorColor = onPrimarySurfaceColor;
			primaryColor = primarySurfaceColor;
			scaffoldBackgroundColor = background;
			secondaryHeaderColor = if isDark then Tailwind(Color3.fromHex("#9e9e9e"))[700] else Tailwind(primary)[50];
			selectedRowColor = Color3.fromHex("#f5f5f5");
			shadowColor = Color3.fromRGB();
			splashColor = if isDark then getColorFromTone(Color3.fromHex("#cccccc"), (64/255) * 100) else getColorFromTone(Color3.fromHex("#c8c8c8"), (102/255) * 100);
			toggleableActiveColor = if isDark then Tailwind(Color3.fromHex("#64ffda"))[200] else Tailwind(primary)[600];
			unselectedWidgetColor = if isDark then getColorFromTone(Color3.fromHex("#ffffff"), 70) else getColorFromTone(Color3.fromRGB(), 54);
		};
	end);
	
	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
})