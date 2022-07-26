local Package = script.Parent;

local Color = require(Package.Utility.Color);
local ColourUtils = require(Package.Utility.ColourUtils);

local getColorFromTone = Color.getColorFromTone;

local State = require(Package.Parent.Core.Value);
local Computed = require(Package.Parent.Core.Computed);

local Palette = ColourUtils.Palette;

local Tailwind = Palette.Tailwind;

local class = {};

local CLASS_METATABLE = {__index = class};
local CLASS_CONSTRUCTORS = {};

local function new(colorScheme, textTheme)
	local self = setmetatable({}, CLASS_METATABLE);
	
	self.colorScheme = colorScheme;
	self.textTheme = textTheme;
	
	local primarySurfaceColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			return self.colorScheme.colors:get()["surface"];
		end
		return self.colorScheme.colors:get()["primary"];
	end);
	local onPrimarySurfaceColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			return self.colorScheme.colors:get()["onSurface"];
		end
		return self.colorScheme.colors:get()["onPrimary"];
	end);

	self.appBarColor = Computed(function()
		return primarySurfaceColor:get();
	end);
	self.backgroundColor = Computed(function()
		return self.colorScheme.colors:get()["background"];
	end);
	self.canvasColor = Computed(function()
		return self.colorScheme.colors:get()["background"];
	end);
	self.cardColor = Computed(function()
		return self.colorScheme.colors:get()["surface"];
	end);
	self.dialogBackgroundColor = Computed(function()
		return self.colorScheme.colors:get()["background"];
	end);
	self.disabledColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(Color3.fromHex("#ffffff"), 100-38);
		end
		return getColorFromTone(Color3.fromRGB(), 38);
	end);
	self.dividerColor = Computed(function() -- opacity
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(self.colorScheme.colors:get()["surface"], 100-12);
		end
		return getColorFromTone(self.colorScheme.colors:get()["surface"], 12);
	end);
	self.errorColor = Computed(function()
		return self.colorScheme.colors:get()["error"];
	end);
	self.focusColor = Computed(function() -- opacity
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(Color3.fromRGB(), 100-12);
		end
		return getColorFromTone(Color3.fromHex("#ffffff"), 12);
	end);
	self.highlightColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(Color3.fromHex("#cccccc"), 100 - ((64/255) * 100));
		end
		return getColorFromTone(Color3.fromHex("#c8c8c8"), (102/255) * 100);
	end);
	self.hintColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(Color3.fromRGB(), 100-60);
		end
		return getColorFromTone(Color3.fromHex("#ffffff"), 60);
	end);
	self.hoverColor = Computed(function() -- opacity
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(Color3.fromRGB(), 100-4);
		end
		return getColorFromTone(Color3.fromHex("#ffffff"), 4);
	end);
	self.indicatorColor = Computed(function()
		return onPrimarySurfaceColor:get();
	end);
	self.primaryColor = Computed(function()
		return primarySurfaceColor:get();
	end);
	self.scaffoldBackgroundColor = Computed(function()
		return self.colorScheme.colors:get()["background"];
	end);
	self.secondaryHeaderColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			local swatch = Tailwind(Color3.fromHex("#9e9e9e"));
			return swatch[700]; -- may need to be 50
		end
		local swatch = Tailwind(self.colorScheme.colors:get()["primary"]);
		return swatch[50]; -- may need to be 700
	end);
	self.selectedRowColor = State(Color3.fromHex("#f5f5f5"));
	self.shadowColor = State(Color3.fromRGB());
	self.splashColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(Color3.fromHex("#cccccc"), (64/255) * 100);
		end
		return getColorFromTone(Color3.fromHex("#c8c8c8"), (102/255) * 100);
	end);
	self.toggleableActiveColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			local swatch = Tailwind(Color3.fromHex("#64ffda"));
			return swatch[200];
		end
		local swatch = Tailwind(self.colorScheme.colors:get()["primary"]);
		return swatch[600];
	end);
	self.unselectedWidgetColor = Computed(function()
		if (self.colorScheme.isDark:get()) then
			return getColorFromTone(Color3.fromHex("#ffffff"), 70);
		end
		return getColorFromTone(Color3.fromRGB(), 54);
	end);
	
	return self;
end

return setmetatable({}, {
	__index = CLASS_CONSTRUCTORS,
	__call = function(cls, ...)
		return new(...);
	end,
})