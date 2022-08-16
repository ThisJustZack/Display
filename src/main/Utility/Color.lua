local Color = {};

function Color.getColorFromTone(color: Color3, tone: number) : Color3
	local a = tone / 100;
	local resultWhite = color:lerp(Color3.fromHex("#ffffff"), a);
	local resultBlack = Color3.fromRGB():lerp(color, a);
	return resultBlack:lerp(resultWhite, a);
end

local accentColors = {
	Light = {
		typ = 40;
		onTyp = 100;
		typContainer = 90;
		onTypContainer = 10;
	};
	Dark = {
		typ = 80;
		onTyp = 20;
		typContainer = 30;
		onTypContainer = 90;
	};
};

local neutralColors = {
	Light = {
		background = 99;
		onBackground = 10;
		surface = 99;
		onSurface = 10;
		surfaceVariant = 90;
		onSurfaceVariant = 30;
		outline = 50;
	};
	Dark = {
		background = 10;
		onBackground = 90;
		surface = 10;
		onSurface = 90;
		surfaceVariant = 30;
		onSurfaceVariant = 80;
		outline = 60;
	};
};

local inputs = {"primary", "secondary", "error"};

function Color.schemeFromColors(primary: Color3, secondary: Color3, error: Color3, neutral: Color3, isDark: boolean, tertiary: Color3?) : {[string]: Color3}
	local tbl = {};

	local accents = {};
	local neutrals = {};
	if (isDark) then
		accents = accentColors.Dark;
		neutrals = neutralColors.Dark;
	else
		accents = accentColors.Light;
		neutrals = neutralColors.Light;
	end

	for _, input in inputs do
		for key, tone in accents do
			local newKey = string.gsub(key, "typ", input);
			newKey = string.gsub(newKey, "Typ", input:gsub("^%l", string.upper));

			if (input == "primary") then
				tbl[newKey] = Color.getColorFromTone(primary, tone);
			elseif (input == "secondary") then
				tbl[newKey] = Color.getColorFromTone(secondary, tone);
			elseif (input == "error") then
				tbl[newKey] = Color.getColorFromTone(error, tone);
			end
		end
	end
	
	if (tertiary) then
		local input = "tertiary";
		for key, tone in accents do
			local newKey = string.gsub(key, "typ", input);
			newKey = string.gsub(newKey, "Typ", input:gsub("^%l", string.upper));
			tbl[newKey] = Color.getColorFromTone(tertiary, tone);
		end
	end

	for key, tone in neutrals do
		tbl[key] = Color.getColorFromTone(neutral, tone);
	end

	return tbl;
end

return Color;